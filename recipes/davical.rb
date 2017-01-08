#
# Cookbook Name:: pwnguin
# Recipe:: davical
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

package 'davical'

web_app 'calendar.pwnguin.net' do
  server_name 'pwnguin.net'
  template 'web_app.conf.erb'
  docroot '/usr/share/davical/htdocs'
end
  
