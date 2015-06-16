#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'rbenv::user'
include_recipe 'rbenv::packages'
include_recipe 'rbenv::rbenv'
include_recipe 'rbenv::ruby_build'
include_recipe 'rbenv::install'
