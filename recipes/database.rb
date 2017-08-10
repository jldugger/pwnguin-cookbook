#
# Cookbook Name:: pwnguin
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'postgresql::server'
include_recipe 'database::postgresql'

node.default['postgresql']['config_pgtune']['db_type'] = 'web'

memory = node['memory']['total'].split('kB')[0].to_i
node.default['postgresql']['config_pgtune']['total_memory'] = (memory / 2).floor.to_s + 'kB'

postgresql_connection_info = {
  host: 'localhost',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

postgresql_database_user 'photologue' do
  connection postgresql_connection_info
end

postgresql_database 'photologue' do
  connection postgresql_connection_info
  owner 'photologue'
end

postgresql_database_user 'photologue' do
  connection postgresql_connection_info
  password 'password'
  database_name 'photologue'
  schema_name 'public'
  tables [:all]
  sequences [:all]
  functions [:all]
  privileges [:all]
  action %i[grant grant_schema grant_table grant_sequence grant_function]
end

postgresql_database_user 'jldugger' do
  connection postgresql_connection_info
end

postgresql_database 'gnucash' do
  connection postgresql_connection_info
  owner 'jldugger'
end

postgresql_database_user 'jldugger' do
  connection postgresql_connection_info
  database_name 'gnucash'
  schema_name 'public'
  tables [:all]
  sequences [:all]
  functions [:all]
  privileges [:all]
  action %i[grant grant_schema grant_table grant_sequence grant_function]
end

postgresql_database_user 'davical_app' do
  connection postgresql_connection_info
end

postgresql_database 'davical' do
  connection postgresql_connection_info
  owner 'davical_app'
end

postgresql_database_user 'davical_app' do
  connection postgresql_connection_info
  database_name 'davical'
  schema_name 'public'
  tables [:all]
  sequences [:all]
  functions [:all]
  privileges [:all]
  action %i[grant grant_schema grant_table grant_sequence grant_function]
end

postgresql_database 'davical' do
  connection postgresql_connection_info
  owner 'davical_app'
end

databases = [
  { type: 'local', db: 'davical', user: 'davical_app', addr: nil, method: 'trust' },
  { type: 'local', db: 'photologue', user: 'photologue', addr: nil, method: 'trust' },
  { type: 'local', db: 'gnucash', user: 'jldugger', addr: nil, method: 'md5' }
]

node.default['postgresql']['pg_hba'] = databases + node.default['postgresql']['pg_hba']

directory '/var/backups/postgresql' do
  owner 'postgres'
  mode '600'
end

logrotate_app 'postgresql-backups' do
  path '/var/backups/postgresql/postgresql-dump.sql'
  frequency 'daily'
  rotate 30
  create '640 postgres postgres'
  options %w[missingok delaycopmress ifempty compress dateext]
  postrotate '/usr/bin/sudo -u postgres /usr/bin/pg_dumpall --clean > /var/backups/postgresql/postgresql-dump.sql'
end
