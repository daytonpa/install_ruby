#
# Cookbook Name:: install_ruby
# Recipe:: debian
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Installing latest stable-version of Ruby on Debian platforms
#

# Ensure that the local apt-get cache is updated
execute 'sudo apt-get update'

# Install the apt dependencies required for rbenv and Ruby
node['install_ruby']['debian_packages'].each do |pkg|
  apt_package pkg
end

# We will be using Git to install rbenv and Ruby
apt_package 'git-core'

# Install Ruby with rbenv
include_recipe 'install_ruby::rbenv'
