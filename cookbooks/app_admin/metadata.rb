maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs m2 or m3 admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"


recipe  "app_admin::default", "Install m3 admin"
recipe  "app_admin::debinst", "Installs admin packages"


attribute "app_admin/django_debians",
  :display_name => "comma separated Django admin packages with version",
  :description => "comma separated Django admin packages with version",
  :type => "string",
  :recipes => ["app_admin::debinst"],
  :required => "recommended"


attribute "app_admin/restart",
  :display_name => "Mention if service needs to be restarted after debian installations",
  :description => "Select if service needs to be restarted after debian installations",
  :required => "optional",
  :default => "false",
  :choice => ["true","false"]
