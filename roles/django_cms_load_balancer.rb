name "django_cms_load_balancer"
description "django_cms load balancer"
run_list(
  "recipe[haproxy::app_lb]"
)
override_attributes(
  "haproxy" => {
    "app_server_role" => "django_cms"
  }
)