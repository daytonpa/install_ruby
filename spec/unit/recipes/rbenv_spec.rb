#
# Cookbook Name:: install_ruby
# Spec:: rbenv
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'install_ruby::rbenv' do
  { 'ubuntu' => '16.04',
    'centos' => '7.2.1511'
  }.each do |platform, v|
    context "When converging with default attributes on #{platform.capitalize} #{v}" do

      let(:user) { 'default' }
      let(:group) { 'default' }
      let(:home_dir) { '/home/ruby' }
      let(:ruby_version) { '2.4.0' }
      # let(:bin_path) { 'path' => "#{home_dir}/.rbenv/plugins/ruby-build/bin:#{home_dir}/.rbenv/shims:#{home_dir}/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" }

      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
          node.normal['install_ruby']['user'] = user
          node.normal['install_ruby']['group'] = group
          node.normal['install_ruby']['home_dir'] = home_dir
          node.normal['install_ruby']['ruby_version'] = ruby_version
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'clones .rbenv from Git' do
        expect(chef_run).to sync_git("#{home_dir}/.rbenv").with(
          user: user,
          group: group,
          revision: 'master'
        )
      end

      it 'creates the /.bashrc file from a cookbook file' do
        expect(chef_run).to create_cookbook_file("#{home_dir}/.bashrc").with(
          owner: user,
          group: group,
          mode: '0644'
        )
      end

      it 'creates a plugins directory for .rbenv' do
        expect(chef_run).to create_directory("#{home_dir}/.rbenv/plugins").with(
          owner: user,
          group: group,
          mode: '0755'
        )
      end

      it 'clones the ruby-build plugin from GitHub' do
        expect(chef_run).to sync_git("#{home_dir}/.rbenv/plugins/ruby-build").with(
          user: user,
          group: group,
          revision: 'master'
        )
      end

      it 'clones the ruby-gem-rehash plugin from GitHub' do
        expect(chef_run).to sync_git("#{home_dir}/.rbenv/plugins/rbenv-gem-rehash").with(
          user: user,
          group: group,
          revision: 'master'
        )
      end

      it 'installs the latest stable-version of Ruby with rbenv' do
        expect(chef_run).to run_execute("install Ruby #{ruby_version}").with(
          user: user,
          command: "rbenv install #{ruby_version}"
        )
      end

      it 'sets the Global standard to the latest Ruby version' do
        expect(chef_run).to run_execute('set Global standard').with(
          user: user,
          command: 'rbenv global ' + ruby_version
        )
      end

      it 'installs the bundler' do
        expect(chef_run).to run_execute('gem install bundler').with(
          user: user,
          command: 'gem install bundler'
        )
      end
    end
  end
end
