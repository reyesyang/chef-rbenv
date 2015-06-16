#
# Cookbook Name:: rbenv
# Recipe:: ruby_build
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require_relative './lib/proxy_envs'

user = node[:rbenv][:user]
group = node[:rbenv][:group]
ruby_build_options = node[:rbenv][:plugins][:ruby_build]

directory ruby_build_options[:path] do
  action :create

  user user
  group group
end

git ruby_build_options[:path] do
  action :sync

  user user
  group group
  environment proxy_envs

  repository ruby_build_options[:repository]
  revision ruby_build_options['branch']
  enable_checkout false
end
