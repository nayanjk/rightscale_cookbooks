
# Cookbook Name:: inmobi_wpsite
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Stop services

action :stop do
  log "  Running stop sequence"
  service "fast_cgi" do
    action :stop
    persist false
  end
end

# Start services
action :start do
  log "  Running start sequence"
  service "fast_cgi" do
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

action :install_wpmu do
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
