#
# Cookbook Name:: rbenv
# Recipe:: packages
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install Git and suggested build environment
# https://github.com/sstephenson/ruby-build/wiki#suggested-build-environment

packages = case node['platform']
when 'ubuntu'
  %w(git autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev)
when 'centos'
  %w(git gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel)
end

package packages do
  action :install
end
