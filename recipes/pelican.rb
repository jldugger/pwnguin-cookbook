#
# Cookbook Name:: pwnguin
# Recipe:: pelican
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'virtualenv'

user 'pelican' do
  comment 'pelican blog user'
  system true
  manage_home true
end

directory '/home/pelican/bin/'

cookbook_file '/home/pelican/bin/deploy.sh' do
  mode 0755
end

git '/home/pelican/blog' do
  repository 'https://github.com/jldugger/blog.git'
  revision 'master'
  checkout_branch 'false'
  user 'pelican'
  group 'pelican'
  action :checkout
end

cron 'pelican build & deploy' do
  command '/home/pelican/bin/deploy.sh'
  user 'pelican'
  minute 18
end

directory '/var/www/www.pwnguin.net' do
  owner 'pelican'
end

web_app 'www.pwnguin.net' do
  server_ports %w[80 443]
  server_name 'www.pwnguin.net'
  server_aliases [node['fqdn'], 'pwnguin.net', 'aws.pwnguin.net', 'gcp1.pwnguin.net']
  docroot '/var/www/www.pwnguin.net'
end
