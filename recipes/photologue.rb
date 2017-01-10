#
# Cookbook Name:: pwnguin
# Recipe:: photologue
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apache2'
include_recipe 'build-essential'

package 'python-virtualenv'
package 'python-psycopg2'
package 'python-dev'

include_recipe 'apache2::mod_wsgi'

directory '/var/www/albums.pwnguin.net/django-photologue' do
  recursive true
end

application '/var/www/albums.pwnguin.net/django-photologue' do
  git 'https://github.com/jldugger/albums.pwnguin.net.git'
  virtualenv
  pip_requirements
  django do
    #database 'sqlite:///db.sqlite3'
    database 'postgres://photologue:password@localhost/photologue'
    allowed_hosts ['*']
    debug true
    migrate true
  end
end

file '/var/www/albums.pwnguin.net/django-photologue/album_project/local_settings.py' do
  group 'www-data'
end

web_app 'albums.pwnguin.net' do
  server_name 'albums.pwnguin.net'
  server_aliases [node['fqdn'], 'localhost']
  docroot '/var/www/albums.pwnguin.net/django-photologue'
  wsgi_name 'photologue'
  template 'wsgi_app.conf.erb'
end

execute 'chown' do
  command 'chown -R www-data:www-data /var/www/albums.pwnguin.net/django-photologue/public/media/'
end
