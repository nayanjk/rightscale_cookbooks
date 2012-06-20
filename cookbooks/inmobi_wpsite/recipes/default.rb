#
# Cookbook Name:: inmobi_wpsite
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

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

log "installing mysql package"

node[:inmobi_wpsite][:packages] = [
   "mkhoj-base",
   "mysql-server5.1",
  ]

inmobi_wpsite "install_packages" do
   persist true
   packages node[:inmobi_wpsite][:packages]
   action :install
   end


inmobi_wpsite "install wpmu" do
   persist true
   action :install_wpmu
   end

rightscale_marker :end
