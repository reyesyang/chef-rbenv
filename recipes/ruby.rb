#
# Cookbook Name:: rbenv
# Recipe:: install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require_relative './lib/proxy_envs'

user = node[:rbenv][:user]
group = node[:rbenv][:group]
home = "/home/#{user}"
ruby_version = node[:rbenv][:ruby_version]
ruby_build_path = "#{node[:rbenv][:path]}/cache/ruby-#{ruby_version}.tar.gz"

bash 'Download ruby build to rbenv cache folder' do
  action :run
  guard_interpreter :bash

  user user
  group group
  environment proxy_envs.merge({
    'HOME' => home,
    'USER' => user
  })

  # chown #{user}:#{group} #{ruby_build_path}
  code <<-CODE
    wget #{node[:rbenv][:ruby_build_url]} -O #{ruby_build_path}
  CODE
  only_if %Q([ '#{node[:rbenv][:ruby_build_url]}' ] && (! (echo '#{node[:rbenv][:ruby_sha256sum]}  #{ruby_build_path}' | sha256sum -c)))
end

bash 'Install ruby' do
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
    source ~/.bash_profile
    CONFIGURE_OPTS="--disable-install-doc" rbenv install #{ruby_version}
  CODE
  not_if %Q(source ~/.bash_profile && (rbenv versions | grep '#{ruby_version}'))
end

bash 'Set rubygem source to taobao mirror' do
  action :run
  guard_interpreter :bash

  user user
  group group
  cwd home
  environment proxy_envs.merge({
    'HOME' => home,
    'USER' => user
  })

  code <<-CODE
    RBENV_VERSION=#{ruby_version} gem sources -r #{node[:rbenv][:gem_source_default]}
    RBENV_VERSION=#{ruby_version} gem sources -a #{node[:rbenv][:gem_source_mirror]}
  CODE
  only_if %Q([ '#{node[:rbenv][:gem_source_mirror]}' ] && [ "$(RBENV_VERSION=#{ruby_version} gem source | grep '#{node[:rbenv][:gem_source_default]}')" ])
end
