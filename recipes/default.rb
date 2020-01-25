#
# Cookbook Name:: pwnguin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w[htop httping mtr-tiny sslscan traceroute whois].each do |pkg|
  package pkg do
    action :upgrade
  end
end

# always monitor
node.default['datadog']['api_key'] = '0ddde63f4c13c5d32d53cbadb3798c79'
node.default['datadog']['application_key'] = 'bce81e8f0e1f0987c6117d4c32125e55009e0e70'
include_recipe 'datadog::dd-agent'
