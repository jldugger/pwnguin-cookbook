#
# Cookbook Name:: pwnguin
# Recipe:: shell
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w[screen git ack-grep colordiff fail2ban irssi moreutil
   myrepos pastebinit pwgen pv vim].each do |pkg|
  package pkg do
    action :upgrade
  end
end

user 'jldugger' do
  home '/home/jldugger'
  shell '/bin/bash'
  manage_home true
end

cron 'irc' do
  command '/usr/bin/screen -dmS IRC /usr/bin/irssi'
  time :reboot
  home '/home/jldugger'
  user 'jldugger'
end

group 'sudo' do
  action :modify
  members ['jldugger']
  append true
end

user 'ubuntu' do
  action :remove
end
