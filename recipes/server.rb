#
# Cookbook Name:: pwnguin
# Recipe:: server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'pwnguin::default'

node.default['apache']['mpm'] = 'prefork'
node.default['apache']['prefork']['startservers'] = 2
node.default['apache']['prefork']['minspareservers'] = 2
node.default['apache']['prefork']['maxspareservers'] = 4
node.default['apache']['prefork']['serverlimit'] = 16

# set up web server
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'

include_recipe 'pwnguin::database'
include_recipe 'pwnguin::photologue'
include_recipe 'pwnguin::pelican'
