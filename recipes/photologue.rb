#
# Cookbook Name:: pwnguin
# Recipe:: photologue
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apache2'
include_recipe 'build-essential'

package 'python-virtualenv'

include_recipe 'apache2::mod_wsgi'

directory '/var/www/albums.pwnguin.net/django-photologue' do
  recursive true
end

application '/var/www/albums.pwnguin.net/django-photologue' do
  git 'https://github.com/jldugger/albums.pwnguin.net.git'
  virtualenv
  pip_requirements
  django do
    database 'sqlite:///db.sqlite3'
    allowed_hosts ['*']
    debug true
    migrate true
  end
end

web_app 'albums.pwnguin.net' do
  server_name 'albums.pwnguin.net'
  server_aliases [node['fqdn'], 'www.pwnguin.net', 'aws.pwnguin.net', 'localhost']
  docroot '/var/www/albums.pwnguin.net/django-photologue'
  wsgi_name 'photologue'
  template 'wsgi_app.conf.erb'
end

execute 'chown' do
  command 'chown -R www-data:www-data /var/www/albums.pwnguin.net/django-photologue/public/media/'
end
