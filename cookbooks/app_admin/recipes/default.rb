#
# Cookbook Name:: app_admin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

log "  Setting provider specific settings for admin"
node[:app][:provider] = "app"


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
    node[:app][:packages] = [
      #"java-gcj-compat-dev",
      "python-psycopg2",            
      "python-flup",
      "Python-package",
      "django",
      "python-beautifulsoup",
      "python-cheetah",
      "Inmobi-django-admin",
      "Inmobi-django-admin-css",
      "inmobi-m3admin-config",
      "inmobi-django-sorting-pagination-modules",

    ]
  end
end
app "default" do
  persist true
  provider node[:app][:provider]
  packages node[:app][:packages]
  action :install
end
rightscale_marker :end
#
