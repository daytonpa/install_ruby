#
# Cookbook Name:: install_ruby
# Recipe:: user
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Creates default users for the node
#
# Create the default group on the node
group node['install_ruby']['group']

# Create the default user on the node
user node['install_ruby']['user'] do
	# Creates new directories for new users
	supports :manage_home => true

	gid node['install_ruby']['group']
	shell '/bin/bash'
	home node['install_ruby']['home_dir']
end
