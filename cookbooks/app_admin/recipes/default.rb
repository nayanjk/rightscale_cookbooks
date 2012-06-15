#
# Cookbook Name:: app_admin
# Recipe:: default
#
# Copyright 2012, Nayan
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin



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
    node[:app_admin][:packages] = [
      #"java-gcj-compat-dev",
      "python-psycopg2",            
      "python-flup",
      "mkhoj-base",
      "build-essential",
      "python2.6-dev",
      "libfftw3-dev",
      "gcc",
      "Python-package",
      "django=1.2-1284962466",
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
end

#Install thrift if Its admin M3
if var == 1

     log "copying Thrift file from appkg1.ev1.inmobi.com"

     remote_file "/tmp/Thrift.tar.gz" do
     source "http://appkg1.ev1.inmobi.com/Thrift.tar.gz"
     end

     log "extracting Thrift"
    
     execute "extract thrift" do
     command <<-COMMAND
     tar -zxf Thrift.tar.gz -C /tmp
     COMMAND
     end
    
     log "installing Thrift"
     execute "install thrift" do
     cwd "/tmp"
     command <<-INST
       (cd Thrift-0.5.0/ && python setup.py install)
     INST
     end

end

service "django" do
 action :start
end

rightscale_marker :end
#
