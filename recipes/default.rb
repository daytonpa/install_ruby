#
# Cookbook Name:: install_ruby
# Recipe:: default
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# This recipe acts a smart run-list
#
# Create the default user and group for the node
include_recipe 'install_ruby::user'

begin
  include_recipe "install_ruby::#{node['install_ruby']['installation_platform']}"
rescue Chef::Exceptions::RecipeNotFound
  raise Chef::Exceptions::RecipeNotFound, 'The platform you are using is not supported' \
    'by this cookbook.  Please review the README.md' \
    'for supported platforms.' \
end
