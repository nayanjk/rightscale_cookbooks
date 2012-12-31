#
# Cookbook Name:: app_admin
# Recipe:: default
#
# Copyright 2012, Nayan
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

node[:app_admin][:provider] = "app_admin"

    node[:app_admin][:packages] = [
      "python-psycopg2",            
      "python-flup",
      "python-pip",
      "mkhoj-base",
      "build-essential",
      "python2.6-dev",
      "libfftw3-dev",
      "gcc",
      "Python-package",
      "django=1.2-1284962466",
      "python-beautifulsoup",
      "python-cheetah",
      "inmobi-django-sorting-pagination-modules",

    ]
  

app_admin "install_packages" do
  persist true
  packages node[:app_admin][:packages]
  action :install
end

template "/etc/init.d/django" do
  source "django.erb"
  owner "root"
  group "root"
  mode 0755
  variables({ 
    :base => "/opt/mkhoj/var/django/mkhojM3/manage.py", 
  })

end

#Install thrift if Its admin M3
   app_admin "install_thrift" do
   persist true
  action :install_thrift
end
rightscale_marker :end
#
