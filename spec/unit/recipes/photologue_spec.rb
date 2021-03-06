#
# Cookbook Name:: pwnguin
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pwnguin::photologue' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end
    before do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
