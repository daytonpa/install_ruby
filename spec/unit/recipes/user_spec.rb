#
# Cookbook Name:: install_ruby
# Spec:: user
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'install_ruby::user' do
  { 'ubuntu' => '16.04',
    'centos' => '7.2.1511'
  }.each do |platform, v|
    context "When all attributes are default on #{platform.capitalize} #{v}" do
      let(:user) { 'default' }
      let(:group) { 'default' }
      let(:home_dir) { '/home/ruby' }

      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
          node.normal['install_ruby']['user'] = user
          node.normal['install_ruby']['group'] = group
          node.normal['install_ruby']['home_dir'] = home_dir
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'creates the default user' do
        expect(chef_run).to create_user(user).with(
          group: group,
          home: home_dir
        )
      end

      it 'creates the default group' do
        expect(chef_run).to create_group(group)
      end
    end
  end
end
