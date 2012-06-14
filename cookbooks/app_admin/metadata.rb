maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs m2 or m3 admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "app"

recipe  "app_admin::default", "Install m2 or m3 admin"

attribute "app_adroit/function",
  :display_name => "which admin M2 or M3",
  :description => "whether admin m2 or m3",
  :choice => [ "M2", "M3"],
  :recipes => ["app_admin::default"],
  :required => "required"
