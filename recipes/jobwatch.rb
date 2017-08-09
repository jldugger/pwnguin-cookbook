#
# Cookbook Name:: pwnguin
# Recipe:: jobwatch
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w[jq moreutils].each do |pkg|
  package pkg
end

userdir = node['pwnguin']['jobwatch']['userdir']

user 'jobwatch' do
  comment 'jobwatch user'
  system true
  manage_home true
end

cookbook_file "#{userdir}/.gitconfig" do
  owner 'jobwatch'
  group 'jobwatch'
  source 'jobwatch/gitconfig'
end

git "#{userdir}/jobsfeed" do
  repository 'git@github.com:jldugger/jobsfeed.git'
  revision 'master'
  action :checkout
  user 'jobwatch'
  group 'jobwatch'
end

git "#{userdir}/jobwatch" do
  repository 'https://github.com/jldugger/jobwatch'
  revision 'master'
  user 'jobwatch'
  group 'jobwatch'
  action :checkout
end

cron 'jobwatch update' do
  command "cd #{userdir}/jobsfeed/ && #{userdir}/jobwatch/jobwatch"
  user 'jobwatch'
  minute 5
end
