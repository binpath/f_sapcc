#
# Cookbook:: f_sapcc
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

if platform?('ubuntu')
  include_recipe 'f_sapcc::ubuntu'
else
  include_recipe 'f_sapcc::centos'
end