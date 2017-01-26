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

%w(htop screen git ack-grep colordiff fail2ban httping irssi ldapvi moreutils
   mtr-tiny myrepos pastebinit pwgen pv sslscan traceroute vim whois).each do |pkg|
  package pkg do
    action :upgrade
  end
end

user 'jldugger' do
  home '/home/jldugger'
  shell '/bin/bash'
  manage_home true
end

group 'sudo' do
  action :modify
  members ['jldugger']
  append true
end

user 'ubuntu' do
  action :remove
end
