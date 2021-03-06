#
# Cookbook Name:: pwnguin
# Recipe:: davical
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

node.default['apache']['mpm'] = 'prefork'

include_recipe 'apache2::default'

package 'davical'
package 'libapache2-mod-php'
package 'pwauth'

web_app 'calendar.pwnguin.net' do
  server_name 'calendar.pwnguin.net'
  template 'web_app.conf.erb'
  docroot '/usr/share/davical/htdocs'
  directory_index %w[index.php index.html]
  aliases ['/images/ /usr/share/davical/htdocs/images/']
end

cookbook_file '/etc/davical/config.php' do
  source 'config.php'
end
