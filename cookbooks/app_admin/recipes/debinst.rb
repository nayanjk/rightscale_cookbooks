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
       end
    else
       log "Package is #{p} and version is not defined"
       package p
    end
  end

   if ( node[:app_admin][:restart] == "true" )
   service "django" do
   action :restart
   end
   else
      if ( node[:app_admin][:restart] == "false" )
           service "django" do
           action :start
           end
       else
             service "django" do
             action :nothing
             end
      end
  end 
  

rightscale_marker :end
