#
# Cookbook Name:: app_admin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

log "  Setting provider specific settings for admin"
node[:app][:provider] = "app"


case node[:platform]
when "ubuntu", "debian"
  log "Entered Ubuntu platform case"
  case node[:app_admin][:function]
  when "M2"
    log "Entered m2 admin type case"
    node[:app][:packages] = [
      "python-psycopg2",
      "python-flup",             


#"java-gcj-compat-dev",
    ]
  when "M3"
    node[:app][:packages] = [
      #"java-gcj-compat-dev",
      "python-psycopg2",            
      "python-flup",
      "mkhoj-base",
      "build-essential",
      "python2.6-dev",
      "libfftw3-dev",
      "gcc",
      "Python-package",
      "django",
      "python-beautifulsoup",
      "python-cheetah",
      "Inmobi-django-admin",
      "Inmobi-django-admin-css",
      "inmobi-m3admin-config",
      "inmobi-django-sorting-pagination-modules",

    ]
  var=1
  end
  
end
app "default" do
  persist true
  provider node[:app][:provider]
  packages node[:app][:packages]
  action :install
end

template "/etc/init.d/django" do
  source "django.erb"
  owner "root"
  group "root"
  mode 0755
end
if var == 1
     log "copying Thrift file from appkg1"
     code <<-EOH
      wget http://appkg1.ev1.inmobi.com/Thrift.tar.gz
      EOH

     log "compiling Thrift ....."
     bash "compile thrift" do
     code <<-EOS
     tar -xzf Thrift.tar.gz} -C /tmp
     cd /tmp/Thrift-0.5.0
     python setup.py install
     EOS
     end
end
service "django" do
 action :start
end

rightscale_marker :end
#
