
# Cookbook Name:: app_admin
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Stop services

action :stop do
  log "  Running stop sequence"
  service "django" do
    action :stop
    persist false
  end
end

# Start services
action :start do
  log "  Running start sequence"
  service "django" do
    action :start
    persist false
  end

end

# Restart services
action :restart do
  log "  Running restart sequence"
  action_stop
     sleep 5
  action_start
end

#Installing specified packages
action :install do
  log " Running apt-get update"
  packages = new_resource.packages
  execute "update apt cache" do
    command "apt-get update"
    ignore_failure true
  end

log " Packages which will be installed: #{packages}"
  v = ""
  packages.each do |p|
    if ( p =~ /(.*)=(.*)/ )
       log "Version defined in #{p} so spliting"
       p = $1
       v = $2
       log "Package is #{p} and version #{v}"
       log "installing #{p} #{v}"
       package p do
          version "#{v}"
          options "--force-yes"
       end
    else
       log "Package is #{p} and version is not defined"
       package p do
       options "--force-yes"
       end
    end
  end
end

action :install_thrift do
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
       (cd Thrift-0.5.0/ && python setup.py install && pip install apscheduler && pip install beautifulsoup && pip install bittornado && pip install cheetah && pip install gnupginterfacex && pip install thrift && pip install distribute && pip install django-mptt && pip install flup && pip install httplib2 && pip install launchpadlib && pip install lazr.restfulclient && pip install lazr.uri && pip install numpy && pip install oauth && pip install psycopg2 && pip install pyopenssl && pip install pycrypto && pip install python-apt && pip install python-dateutil && pip install simplejson && pip install ufw && pip install unattended-upgrades && pip install wadllib && pip install web.py && pip install wsgiref && pip install zope.interface)
     INST
     end  
end
