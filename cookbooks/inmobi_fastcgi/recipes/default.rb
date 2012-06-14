#
# Cookbook Name:: inmobi_fastcgi
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node[:platform]
when "ubuntu","debian"
  package "php5" do
    action :install
  end
end

case node[:platform]
when "ubuntu","debian"
  package "php5-cgi" do
    action :install
  end
end

template "/etc/init.d/php-cgi" do
  source "php-cgi.erb"
  owner "root"
  group "root"
  mode 0755
end

service "php-cgi" do
  action :start
end
