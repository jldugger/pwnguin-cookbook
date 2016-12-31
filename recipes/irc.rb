#
# Cookbook Name:: pwnguin
# Recipe:: irc
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'irssi'
package 'screen'

cron 'irc' do
  user 'jldugger'
  time :reboot
  command '/usr/bin/screen -dmS IRC /usr/bin/irssi'
end
