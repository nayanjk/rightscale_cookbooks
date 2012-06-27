#
# Cookbook Name:: inmobi_wpsite
# Resource:: inmobi_wpsite::default
#


# Install packages required for application server setup
actions :install
  # Set of installed packages
  attribute :packages, :kind_of => Array

# Runs application server start sequence
actions :start

# Runs application server stop sequence
actions :stop

# Runs application server restart sequence
actions :restart

actions :install_devwpmu

# Updates application source files from the remote repository
# Action designed to setup APP LWRP with common parameters required for source code update/download
actions :code_update
  #Destination for source code download
  attribute :destination, :kind_of => String
