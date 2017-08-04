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
    database 'postgres://photologue:password@localhost/photologue'
    allowed_hosts %w[* u'pwnguin.net' u'albums.pwnguin.net' u'www.pwnguin.net']
    debug true
    migrate true
    local_settings_source 'local_settings.py.erb'
    local_settings_variables node['pwnguin']['photologue']
  end
end

file '/var/www/albums.pwnguin.net/django-photologue/album_project/local_settings.py' do
  group 'www-data'
end

web_app 'albums.pwnguin.net' do
  server_name 'albums.pwnguin.net'
  docroot '/var/www/albums.pwnguin.net/django-photologue'
  wsgi_name 'photologue'
  template 'wsgi_app.conf.erb'
end

execute 'chown' do
  command 'chown -R www-data:www-data /var/www/albums.pwnguin.net/django-photologue/public/media/'
end
