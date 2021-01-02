#
# Cookbook Name:: pwnguin
# Recipe:: server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'pwnguin::default'

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
