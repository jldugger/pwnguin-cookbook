#
# Cookbook Name:: pwnguin
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

postgresql_server_install 'postgresql' do
  port 5432
  action [:install, :create]
end

node.default['postgresql']['config_pgtune']['db_type'] = 'web'

memory = node['memory']['total'].split('kB')[0].to_i

postgresql_user 'photologue'

postgresql_database 'photologue' do
  owner 'photologue'
end

postgresql_user 'jldugger'

postgresql_database 'gnucash' do
  owner 'jldugger'
end

postgresql_user 'davical_app'

postgresql_database 'davical' do
  owner 'davical_app'
end

databases = [
  { type: 'local', db: 'davical', user: 'davical_app', addr: nil, method: 'trust' },
  { type: 'local', db: 'photologue', user: 'photologue', addr: nil, method: 'trust' },
  { type: 'local', db: 'gnucash', user: 'jldugger', addr: nil, method: 'md5' }
]

directory '/var/backups/postgresql' do
  owner 'postgres'
  group 'postgres'
  mode '650'
end

logrotate_app 'postgresql-backups' do
  path '/var/backups/postgresql/postgresql-dump.sql'
  frequency 'daily'
  rotate 30
  create '640 postgres postgres'
  options %w[missingok delaycompress ifempty compress dateext]
  postrotate '/usr/bin/sudo -u postgres /usr/bin/pg_dumpall --clean > /var/backups/postgresql/postgresql-dump.sql'
end

file '/var/backups/postgresql/postgresql-dump.sql' do
  owner 'postgres'
  action :create_if_missing
end

users_manage 'postgres' do
  data_bag 'backup_users'
end
