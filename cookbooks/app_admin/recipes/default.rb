#
# Cookbook Name:: app_admin
# Recipe:: default
#
# Copyright 2012, Nayan
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

node[:app_admin][:provider] = "app_admin"

case node[:platform]
when "ubuntu", "debian"
  log "Entered Ubuntu platform case"
  case node[:app_admin][:function]
  when "M2"
    log "Entered m2 admin type case"
    node[:app_admin][:packages] = [
      "python-psycopg2",
      "python-flup",
      "mkhoj-base",
      "build-essential",
      "django=1.2-1284962466",
      "django-admin-tovs=1.1.0-1303200931",
      "inmobi-email-package=1328263143",
    ]
  when "M3"
    node[:app_admin][:packages] = [
      #"java-gcj-compat-dev",
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
  var=1
  end
  
end

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
  if var == 1
  variables({ 
    :base => "/opt/mkhoj/var/django/mkhojM3/manage.py", 
  })
  else
  variables({
    :base => "/opt/mkhoj/var/django/mkhoj/manage.py",
  })
  end


end

#Install thrift if Its admin M3
if var == 1
   app_admin "install_thrift" do
   persist true
  action :install_thrift
end
end

rightscale_marker :end
#
