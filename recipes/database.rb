#
# Cookbook Name:: pwnguin
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'postgresql::server'
include_recipe 'database::postgresql'
#include_recipe 'postgresql::ruby'

node.default['postgresql']['config_pgtune']['db_type'] = 'web'

memory = node['memory']['total'].split('kB')[0].to_i
node.default['postgresql']['config_pgtune']['total_memory'] = (memory / 2).floor.to_s + 'kB'

# include_recipe 'postgresql::config_pgtune'

postgresql_connection_info = {
  :host     => 'localhost',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

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
  action [:grant, :grant_schema, :grant_table, :grant_sequence, :grant_function]
end


postgresql_database 'davical' do
  connection postgresql_connection_info
  owner 'davical_app'
end

node.default['postgresql']['pg_hba'] = [{ :type => 'local', :db => 'davical', :user => 'davical_app', :addr => nil, :method => 'trust'}] + node.default['postgresql']['pg_hba']
