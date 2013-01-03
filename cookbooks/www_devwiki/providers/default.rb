
# Cookbook Name:: www_devwiki
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







action :install_wpmu do
   log "copying wpmu.tar.gz file from pkg.uj2.inmobi.com"

     remote_file "/tmp/developer_wiki.tar.gz" do
     source "http://pkg.uj2.inmobi.com:9999/developer_wiki.tar.gz"
     end

     
     remote_file "/tmp/developer_wiki.sql" do
     source "http://pkg.uj2.inmobi.com:9999/developer_wiki.sql"
     end


     log "extracting wpmu"
    
     execute "extract_devwpmu" do
     command <<-COMMAND
     tar -zxf developer_wiki.tar.gz -C /usr/local/html/
     COMMAND
     end
    
end
