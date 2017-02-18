#
# Cookbook Name:: install_ruby
# Recipe:: rbenv
# Author:: Patrick Dayton  pdayton@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Installing latest stable-version of Ruby on Debian platforms
#

node['install_ruby']['home_dir'].tap do |home|

  # directory home + '/.rbenv' do
  #   owner node['install_ruby']['user']
  #   group node['install_ruby']['group']
  #   mode '0644'
  # end

  # Clone rbenv from Git
  git home + '/.rbenv' do
    user node['install_ruby']['user']
    group node['install_ruby']['group']
    repository 'https://github.com/rbenv/rbenv.git'
    revision 'master'
  end

  # Create the /.bashrc file
  cookbook_file home + '/.bashrc' do
    owner node['install_ruby']['user']
    group node['install_ruby']['group']
    mode '0644'
    source 'bashrc'
  end

  # Create a plugins directory for rbenv
  plugins = '/.rbenv/plugins'
  directory home + plugins do
    owner node['install_ruby']['user']
    group node['install_ruby']['group']
    mode '0755'
  end

  # Clone the ruby-build plugin from GitHub
  git home + plugins + '/ruby-build' do
    user node['install_ruby']['user']
    group node['install_ruby']['group']
    repository 'https://github.com/rbenv/ruby-build.git'
    revision 'master'
  end

  git home + plugins + '/rbenv-gem-rehash' do
    user node['install_ruby']['user']
    group node['install_ruby']['group']
    repository 'https://github.com/rbenv/rbenv-gem-rehash.git'
    revision 'master'
  end
end

# Install the latest version of Ruby
execute "install Ruby #{node['install_ruby']['ruby_version']}" do
  user node['install_ruby']['user']
  environment 'PATH' => node['install_ruby']['bin_path']
  command "rbenv install #{node['install_ruby']['ruby_version']}"
  not_if do
		Dir.exist?("#{node['install_ruby']['home_dir']}/.rbenv/versions/#{node['install_ruby']['ruby_version']}")
	end
end

## Set Global standard to the latest version
execute 'set Global standard' do
  user node['install_ruby']['user']
	environment 'PATH' => node['install_ruby']['bin_path']
	command 'rbenv global ' + node['install_ruby']['ruby_version']
end

execute 'gem install bundler' do
  user node['install_ruby']['user']
	environment 'PATH' => node['install_ruby']['bin_path']
	command 'gem install bundler'
end
