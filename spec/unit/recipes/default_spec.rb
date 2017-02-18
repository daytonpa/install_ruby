#
# Cookbook Name:: install_ruby
# Spec:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'install_ruby::default' do
  { 'ubuntu' => '16.04',
    'centos' => '7.2.1511'
  }.each do |platform, v|
    context "When all attributes are default on #{platform.capitalize} #{v}." do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: platform, version: v) do |node|
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it "includes the 'user' recipe" do
        expect(chef_run).to include_recipe('install_ruby::user')
      end

      case platform
      when 'ubuntu'
        it "includes the 'debian' installation recipe" do
          expect(chef_run).to include_recipe('install_ruby::debian')
        end
        it "skips the 'rhel' installation recipe" do
          expect(chef_run).to_not include_recipe('install_ruby::rhel')
        end
      when 'centos'
        it "includes the 'rhel' installation recipe" do
          expect(chef_run).to include_recipe('install_ruby::rhel')
        end
        it "skips the 'debian' installation recipe" do
          expect(chef_run).to_not include_recipe('install_ruby::debian')
        end
      end
    end
  end
end
