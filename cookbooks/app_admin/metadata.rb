maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs m2 or m3 admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"


recipe  "app_admin::default", "Install m2 or m3 admin"
recipe  "app_admin::debinst", "Installs admin packages"

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

attribute "app_admin/django_debians",
  :display_name => "comma separated Django admin packages with version",
  :description => "comma separated Django admin packages with version",
  :type => "string",
  :recipes => ["app_admin::debinst"],
  :required => "recommended"


attribute "app_inmobi_debinst/service",
  :display_name => "Mention the generic service name.",
  :description => "This name will be used as init.d service name if start-stop commands are not mentioned",
  :required => true,
  :default => nil


attribute "app_inmobi_debinst/restart",
  :display_name => "Mention if service needs to be restarted after debian installations",
  :description => "Select if service needs to be restarted after debian installations",
  :required => "optional",
  :default => "true",
  :choice => ["true","false"]

attribute "app_inmobi_debinst/startcmd",
  :display_name => "Mention the complete command used to start the service",
  :description => "Eg: svc -u /etc/service-puppet",
  :required => "optional",
  :default => nil

attribute "app_inmobi_debinst/stopcmd",
  :display_name => "Mention the complete command used to stop the service",
  :description => "Eg: svc -d /etc/service-puppet",
  :required => "optional",
  :default => nil
