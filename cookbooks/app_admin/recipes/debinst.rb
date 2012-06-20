rightscale_marker :begin


if node[:app_admin][:stopcmd] == nil || node[:app_admin][:startcmd] == nil
   node[:app_admin][:startcmd] = "/etc/init.d/#{node[:app_admin][:service]} start"
   node[:app_admin][:stopcmd] = "/etc/init.d/#{node[:app_admin][:service]} stop"
end

service "#{node[:app_admin][:service]}" do
  start_command "#{node[:app_admin][:startcmd]}"
  stop_command "#{node[:app_admin][:stopcmd]}"
  action :nothing
end



  packages = node[:app_admin][:django_debians]
  packages.gsub(/\s+/, "").split(",").uniq.each do |p|

  v = ""
    if ( p =~ /(.*)=(.*)/ )
       log "Version defined in #{p} so spliting"
       p = $1
       v = $2
       log "Package is #{p} and version #{v}"
       log "installing #{p} #{v}"
       package p do
          version "#{v}"
          notifies :restart , resources(:service => "#{node[:app_admin][:service]}") unless node[:app_admin][:restart] == "false"
       end
    else
       log "Package is #{p} and version is not defined"
       package p
       notifies :restart , resources(:service => "#{node[:app_admin][:service]}") unless node[:app_admin][:restart] == "false"
    end
  end

rightscale_marker :end
