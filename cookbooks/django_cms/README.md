Description
===========

Support cookbook for Django CMS application.

Requirements
============

The db_bootstrap recipe requires using the Opscode application cookbook.

Usage
=====

Database Bootstrap
------------------

This recipe wraps the required manage.py (non-interactive) commands to create the database and initial superuser required by Django CMS:

    $ python manage.py syncdb --all --noinput
    $ python manage.py createsuperuser --noinput --username=admin --email=admin@foo.com
    $ export DJANGO_SETTINGS_MODULE=settings;python -c "from django.contrib.auth.models import User; u=User.objects.get(username='admin');u.set_password('foobar');u.save();"

This recipe is designed to be used with the Opscode application cookbook, and only one time. It removes itself with a Ruby block resource when the  resource executes successfully.

License and Author
==================

Author:: Seth Chisamore (<schisamo@opscode.com>)

Copyright:: 2011, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
