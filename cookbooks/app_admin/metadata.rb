maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs m2 or m3 admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe  "app_admin::default", "Install m2 or m3 admin"

attribute "app_admin/function",
  :display_name => "which admin M2 or M3",
  :description => "whether admin m2 or m3",
  :choice => ["M2", "M3"],
  :recipes => ["app_admin::default"],
  :required => "required"

attribute "app_admin/djangobase",
  :display_name => "Django base for M2 or M3",
  :description => "base dir vaules",
  :type => "string",
  :required => "recommended"

attribute "app_admin/django_admin_package",
  :display_name => "Django admin packake with version",
  :description => "django admin package",
  :type => "string",
  :recipes => ["app_admin::default"],
  :required => "recommended"

attribute "app_admin/django_admin_css",
  :display_name => "Django admin css with version",
  :description => "django admin css",
  :type => "string",
  :recipes => ["app_admin::default"],
  :required => "recommended"

attribute "app_admin/django_admin_config",
  :display_name => "Django admin config with version",
  :description => "django admin config",
  :type => "string",
  :recipes => ["app_admin::default"],
  :required => "recommended"
