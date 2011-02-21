#
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: django_cms
# Recipe:: db_bootstrap
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# THIS RECIPE IS DESTRUCTIVE. Normally when running the db:bootstrap rake
# task in Radiant, it prompts the user:
#
# This task will destroy any data in the database. Are you sure you want to 
# continue? [yn] y
# 
# The yes | below will automatically say yes. Only use this recipe if you
# know what you are doing. Otherwise, run the db:bootstrap manually.
#
# The file resource below for the radiant_config_cache.txt is because when
# the db:bootstrap is run by root in the recipe, the file is not writable
# by the default user that runs the application.

app = data_bag_item("apps", "django_cms")
virtualenv = resources(:python_virtualenv => app['id'])
python_bin = ::File.join(virtualenv.path, "bin", "python")

execute "db_bootstrap" do
  command <<-EOS
  #{python_bin} manage.py syncdb --all --noinput
  #{python_bin} manage.py createsuperuser --noinput --username=admin --email=admin@example.com
  #{python_bin} -c \"from django.contrib.auth.models import User; u=User.objects.get(username='admin');u.set_password('djangocms');u.save();\"  
  EOS
  cwd "#{app['deploy_to']}/current"
  environment ({'DJANGO_SETTINGS_MODULE' => 'settings'}) 
  #ignore_failure true
  notifies :create, "ruby_block[remove_django_cms_bootstrap]", :immediately
end

ruby_block "remove_django_cms_bootstrap" do
  block do
    Chef::Log.info("Django CMS Database Bootstrap completed, removing the destructive recipe[django_cms::db_bootstrap]")
    node.run_list.remove("recipe[django_cms::db_bootstrap]") if node.run_list.include?("recipe[django_cms::db_bootstrap]")
  end
  action :nothing
end