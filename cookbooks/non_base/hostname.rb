#
# Cookbook Name:: non_base
# Recipe:: hostname
#
# Copyright 2015, NIFTY Corporation
#
# All rights reserved - Do Not Redistribute
#

# host名の一時的な変更
case node[:platform_version][0]
when "6"
  execute "chenge_hostname" do
    command "hostname #{node['non_base']['hostname']}"
    not_if "hostname | grep \"#{node['non_base']['hostname']}\""
  end

  # 設定ファイルを変更後、再起動
  template "/etc/sysconfig/network" do
    owner "root"
    group "root"
    source "templates/network.erb"
    action :create
  end

  service 'network' do
    action [:enable, :restart]
  end
when "7"
  execute "chenge_hostname" do
    command "hostnamectl set-hostname #{node['non_base']['hostname']}"
    not_if "hostname | grep \"#{node['non_base']['hostname']}\""
  end
end

file "/etc/hosts" do
  action :edit
  owner "root"
  group "root"
  block do |content|
    content.gsub!(/^127.0.0.1   localhost/, "127.0.0.1   #{node['non_base']['hostname']}")
  end
end
