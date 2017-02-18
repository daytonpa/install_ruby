#
# Cookbook Name:: install_ruby
# Spec:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'install_ruby::debian' do
  context 'When all attributes are default on Debian platforms' do

    let(:user) { 'default' }
    let(:group) { 'default' }
    let(:home_dir) { '/home/ruby' }

    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.normal['install_ruby']['user'] = user
        node.normal['install_ruby']['group'] = group
        node.normal['install_ruby']['home_dir'] = home_dir
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates the apt-get cache' do
      expect(chef_run).to run_execute('sudo apt-get update')
    end

    it 'installs the necessary packages for rbenv and Ruby' do
      %w(
        autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev
        zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
      ).each do |pkg|
        expect(chef_run).to install_apt_package(pkg)
      end
    end

    it 'installs the git-core package for using Git' do
      expect(chef_run).to install_apt_package('git-core')
    end

    it "includes the 'rbenv' recipe" do
      expect(chef_run).to include_recipe('install_ruby::rbenv')
    end
  end
end
