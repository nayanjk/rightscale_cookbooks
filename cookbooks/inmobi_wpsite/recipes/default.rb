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

template "/tmp/mysql.preseed" do
   source "mysql.preseed.erb"
   owner "root"
   mode "0755"
   end
execute "setting mysql preseed " do
   command "/tmp/mysql.preseed"
   action :nothing
   end





log "setting required mysql data for wpmu"

template "/tmp/setup_mysql_mpmu.sh" do
   source "setup_mysql_wpmu.sh.erb"
   owner "root"
   mode "0755"
   end
execute "setting mysql wpmu data " do
   command "/tmp/setup_mysql_wpmu.sh"
   action :nothing
   end

log "installing mysql package"

node[:inmobi_wpsite][:packages] = [
   "mkhoj-base",
   "mysql-server",
  ]

inmobi_wpsite "install_packages" do
   persist true
   packages node[:inmobi_wpsite][:packages]
   action :install
   end


rightscale_marker :end
