#
# Cookbook Name:: non_base
# Recipe:: iptables
#
# Copyright 2015, NIFTY Corporation
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/iptables" do
  source "templates/iptables.erb"
  action :create
#  notifies :restart, "service[iptables]"
  not_if "iptables -L -n | grep 'REJECT     all  --  0.0.0.0/0            0.0.0.0/0           reject-with icmp-host-prohibited'"
end

# iptablesの設定更新、反映、自動起動
service 'iptables' do
  action [:enable, :restart]
end

