#
# Cookbook Name:: pwnguin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['chef_client']['cron']['hour'] = '*'
node.default['chef_client']['cron']['minute'] = '*/30'
node.default['chef_client']['cron']['mailto'] = 'jldugger+chef@gmail.com'
node.default['chef_client']['cron']['use_cron_d'] = true
node.default['chef_client']['cron']['log_file'] = '/var/log/chef/client.log'
node.default['chef_client']['init_style'] = 'none'

include_recipe 'chef-client::cron'
include_recipe 'chef-client::delete_validation'

%w[htop httping mtr-tiny sslscan traceroute whois].each do |pkg|
  package pkg do
    action :upgrade
  end
end

# always monitor
node.default['datadog']['api_key'] = '0ddde63f4c13c5d32d53cbadb3798c79'
node.default['datadog']['application_key'] = 'bce81e8f0e1f0987c6117d4c32125e55009e0e70'
include_recipe 'datadog::dd-agent'
