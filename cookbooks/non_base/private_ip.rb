#
# Cookbook Name:: non_base
# Recipe:: private_ip
#
# Copyright 2015, NIFTY Corporation
#
# All rights reserved - Do Not Redistribute
#

# プライベートIPアドレスの設定
case node[:platform_version][0] 
when "6"
  template "/etc/sysconfig/network-scripts/ifcfg-eth1" do
    source "templates/ifcfg-eth1.erb"
    action :create
  #  notifies :restart, "service[network]"
  end
when "7"
  template "/etc/sysconfig/network-scripts/ifcfg-ens192" do
    source "templates/ifcfg-ens192.erb"
    action :create
    notifies :restart, "service[network]"
  end
end

service "network" do
  action [:enable, :restart]
end
