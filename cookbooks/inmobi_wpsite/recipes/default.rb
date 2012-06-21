#
# Cookbook Name:: inmobi_wpsite
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

directory "/opt/mkhoj/html" do
  owner "root"
  mode 0755
  recursive true
  end



inmobi_wpsite "install wpmu" do
   persist true
   action :install_wpmu
   end


log "setting preseed for mysql install"

template "/tmp/set_preseed_mysql.sh" do
   source "set_preseed_mysql.sh.erb"
   owner "root"
   mode "0755"
   end

script "setting mysql preseed" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  ./set_preseed_mysql.sh
  EOH
end



node[:inmobi_wpsite][:packages] = [
   "mysql-server",
   "mkhoj-base",
   "php5-mysql",
  ]

log "installing mysql package"


inmobi_wpsite "install_packages" do
   persist true
   packages node[:inmobi_wpsite][:packages]
   action :install
   end

package "apache2.2-common" do
    action :remove
  end

log "setting required mysql data for wpmu"

template "/tmp/setup_mysql_wpmu.sh" do
   source "setup_mysql_wpmu.sh.erb"
   owner "root"
   mode "0755"
   end

script "setting mysql data wpmu" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  ./setup_mysql_wpmu.sh
  EOH
end

rightscale_marker :end
