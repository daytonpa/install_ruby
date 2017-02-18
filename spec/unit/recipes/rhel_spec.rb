#
# Cookbook Name:: install_ruby
# Spec:: rhel
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'install_ruby::rhel' do
  context 'When all attributes are default on RHEL platforms' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511').converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "includes the default recipe from the 'yum' cookbook" do
      expect(chef_run).to include_recipe('yum::default')
    end

    it 'installs the yum dependencies for the installation of rbenv and Ruby' do
      %w(
      zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel
      libffi-devel openssl-devel make bzip2 autoconf automake libtool bison
      curl sqlite-devel
      ).each do |pkg|
        expect(chef_run).to install_yum_package(pkg)
      end
    end

    it 'installs the git-core yum package' do
      expect(chef_run).to install_yum_package('git-core')
    end

    it 'includes the rbenv recipe' do
      expect(chef_run).to include_recipe('install_ruby::rbenv')
    end
  end
end
