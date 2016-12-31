#
# Cookbook Name:: pwnguin
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'postgresql::server'

node.set['postgresql']['config_pgtune']['db_type'] = 'web'

memory = node['memory']['total'].split('kB')[0].to_i
node.set['postgresql']['config_pgtune']['total_memory'] = (memory / 2).floor.to_s + "kB"

#include_recipe 'postgresql::config_pgtune'
