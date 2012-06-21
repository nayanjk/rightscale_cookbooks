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
#execute "setting mysql preseed " do
#   command "bash /tmp/mysql.preseed"
#   action :nothing
#   end

bash "setting_mysql_preseed" do
    code<<-EOF
    bash "/tmp/mysql.preseed"
    EOF
    end

node[:inmobi_wpsite][:packages] = [
   "mysql-server",
   "mkhoj-base",
  ]

log "installing mysql package"


inmobi_wpsite "install_packages" do
   persist true
   packages node[:inmobi_wpsite][:packages]
   action :install
   end



log "setting required mysql data for wpmu"

template "/tmp/setup_mysql_mpmu.sh" do
   source "setup_mysql_wpmu.sh.erb"
   owner "root"
   mode "0755"
   end
#execute "setting mysql wpmu data " do
#   command "bash /tmp/setup_mysql_wpmu.sh"
#   action :nothing
#   end


rightscale_marker :end
