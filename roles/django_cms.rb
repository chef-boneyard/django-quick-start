name "django_cms"
description "django_cms front end application server."
run_list(
  "recipe[mysql::client]",
  "recipe[application]",
  "recipe[django_cms::status]"
)