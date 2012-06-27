maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures www_devwiki"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"



recipe "www_devwiki::default", "Installs dev wiki"

attribute "www_devwiki/mysql_root_password",
  :display_name => "Mysql Server Root Password",
  :description => "enter mysql root password here",
  :type => "string",
  :recipies => ["www_devwiki:default"],
  :required => "required"


