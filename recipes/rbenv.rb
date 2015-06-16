#
# Cookbook Name:: rbenv
# Recipe:: rbenv
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require_relative './lib/proxy_envs'

home = "/home/#{node[:rbenv][:user]}"
user = node[:rbenv][:user]
group = node[:rbenv][:group]

# Git clone rbenv
git node[:rbenv][:path] do
  action :sync

  user user
  group group
  environment proxy_envs

  repository node[:rbenv][:repository]
  revision node[:rbenv][:branch]
  enable_checkout false
end

bash 'Configure rbenv' do
  action :run
  guard_interpreter :bash

  user user
  group group
  cwd home
  environment ({
    'USER' => user,
    'HOME' => home
  })

  code <<-CODE
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  CODE
  not_if %Q(source ~/.bash_profile && (type rbenv | grep 'rbenv is a function'))
end

# Create plugin and cache folder in rbenv root
%w(plugins cache).each do |folder|
  directory "#{node[:rbenv][:path]}/#{folder}" do
    action :create

    user user
    group group
  end
end
