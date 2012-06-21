rightscale_marker :begin



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
          options "--force-yes"
       end
    else
       log "Package is #{p} and version is not defined"
       package p do
       options "--force-yes"
       end
    end
  end

   if ( node[:app_admin][:restart] == "true" )
   service "django" do
   action :restart
   end
  end
      if ( node[:app_admin][:restart] == "false" )
           service "django" do
           action :start
           end
      end             

  

rightscale_marker :end
