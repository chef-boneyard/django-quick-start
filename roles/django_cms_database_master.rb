name "django_cms_database_master"
description "database master for the django_cms application."
run_list(
  "recipe[database::master]"
)