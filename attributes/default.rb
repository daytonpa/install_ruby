#
# Cookbook Name:: install_ruby
# Attributes:: default
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

default['install_ruby']['user'] = 'default'
default['install_ruby']['group'] = 'default'
default['install_ruby']['home_dir'] = '/home/ruby'
default['install_ruby']['ruby_version'] = '2.4.0'
default['install_ruby']['bin_path']		= "#{node['install_ruby']['home_dir']}/.rbenv/plugins/ruby-build/bin:#{node['install_ruby']['home_dir']}/.rbenv/shims:#{node['install_ruby']['home_dir']}/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"


# This section will determine the installation method of Ruby on your node
default['install_ruby'].tap do |ruby|
  case node['platform_family']
  when 'debian'
    ruby['installation_platform'] = 'debian'
  when 'rhel'
    ruby['installation_platform'] = 'rhel'
  else
    nil
  end
end

default['install_ruby']['debian_packages'] = %w(
  autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev
  zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
)
default['install_ruby']['rhel_packages'] = %w(
  zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel
  libffi-devel openssl-devel make bzip2 autoconf automake libtool bison
  curl sqlite-devel
)
