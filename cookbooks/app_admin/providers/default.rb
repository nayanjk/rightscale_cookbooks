
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
  packages = new_resource.packages
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
       end
    else
       package p
    end
end
end

action :install_thrift do
   log "copying Thrift file from apppkg1.wc1.inmobi.com"

     remote_file "/tmp/Thrift.tar.gz" do
     source "http://apppkg1.wc1.inmobi.com/Thrift.tar.gz"
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
