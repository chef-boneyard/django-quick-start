name "django_cms_run_migrations"
description "Run db:migrate on demand for django_cms"
override_attributes(
  "apps" => { 
    "django_cms" => { 
      "production" => { "run_migrations" => true } 
    } 
})