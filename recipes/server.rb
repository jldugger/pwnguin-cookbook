#
# Cookbook Name:: pwnguin
# Recipe:: server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'pwnguin::default'

# apache tuning
node.default['apache']['mpm'] = 'prefork'
node.default['apache']['prefork']['startservers'] = 2
node.default['apache']['prefork']['minspareservers'] = 2
node.default['apache']['prefork']['maxspareservers'] = 4
node.default['apache']['prefork']['serverlimit'] = 16

# set up web server
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_ssl'

# ssl settings

include_recipe 'acme'
node.default['acme']['contact'] = ['mailto:meh@pwnguin.net']
site = 'pwnguin.net'

acme_certificate site do
  crt     "/etc/apache2/ssl/#{site}.crt"
  key     "/etc/apache2/ssl/#{site}.key"
  chain   "/etc/apache2/ssl/#{site}.pem"
  wwwroot '/var/www/www.pwnguin.net'
  alt_names ['www.pwnguin.net']
end

# set up web server
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_ssl'

include_recipe 'pwnguin::pelican'
