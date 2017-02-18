#
# Cookbook Name:: install_ruby
# Recipe:: rhel
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Installing latest stable-version of Ruby on Debian platforms
#

# Update yum
include_recipe 'yum'

# Install the yum dependencies required for rbenv and Ruby
node['install_ruby']['rhel_packages'].each do |pkg|
  yum_package pkg
end

# We will be using Git to install rbenv and Ruby
yum_package 'git-core'

# Install Ruby with rbenv
include_recipe 'install_ruby::rbenv'
