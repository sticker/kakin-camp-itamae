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
  #  notifies :restart, "service[network]"
  end
end

# ルーティング設定
case node[:platform_version][0]
when "6"
  template "/etc/sysconfig/network-scripts/route-eth1" do
    source "templates/route-eth1.erb"
    action :create
  #  notifies :restart, "service[network]"
  end
when "7"
  execute "nmcli" do
    command <<-EOH
nmcli connection modify "System ens192" +ipv4.routes "10.0.0.0/8 #{node['non_base']['gateway']}"
nmcli connection modify "System ens192" +ipv4.routes "172.16.0.0/12 #{node['non_base']['gateway']}"
nmcli connection modify "System ens192" +ipv4.routes "192.168.0.0/16 #{node['non_base']['gateway']}"
EOH
  end
end

service "network" do
  action [:enable, :restart]
end
