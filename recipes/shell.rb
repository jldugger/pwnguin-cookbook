#
# Cookbook Name:: pwnguin
# Recipe:: shell
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w[tmux git ack-grep colordiff sshguard moreutils
   myrepos pastebinit pwgen pv vim].each do |pkg|
  package pkg do
    action :upgrade
  end
end

%w[weechat-curses weechat-plugins].each do |pkg|
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
  command '/usr/bin/tmux new -s IRC /usr/bin/weechat'
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
