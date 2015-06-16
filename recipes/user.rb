#
# Cookbook Name:: rbenv
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

group node['rbenv']['group']

user node['rbenv']['user'] do
  action :create

  group node['rbenv']['user']
  shell '/bin/bash'
end
