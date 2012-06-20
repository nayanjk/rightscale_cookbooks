maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures inmobi_wpsite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe "inmobi_wpsite::default","configures mysql and wpmu"

attribute "inmobi_wpsite/mysql_root_password",
  :display_name => "Mysql Server Root Password",
  :description => "enter mysql root password here",
  :type => "string",
  :recipies => ["inmobi_wpsite:default"],
  :required => "required"

attribute "inmobi_wpsite/language",
  :display_name => "site language/country",
  :description => "which language site to configure",
  :choice => ["global", "japanese"],
  :recipies => ["inmobi_wpsite:default"],
  :required => "required"
