#
# Cookbook Name:: pwnguin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w[htop httping mtr-tiny sslscan traceroute whois].each do |pkg|
  package pkg do
    action :upgrade
  end
end
