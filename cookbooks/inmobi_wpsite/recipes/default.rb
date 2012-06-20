#
# Cookbook Name:: inmobi_wpsite
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

log "setting preeseed for mysql install"

template "/tmp/mysql.preeseed" do
   source "mysql.preseed.erb"
   owner "root"
   mode "0755"
   end
execute "setting mysql preeseed " do
   command "/tmp/mysql.preeseed"
   action :nothing
   end

log "installing mysql package"

package node['inmobi_wpsite']['package_name'] do
   action :install
   end

inmobi_wpsite "install wpmu" do
   persist true
   action :install_wpmu
   end

rightscale_marker :end
