#
# Cookbook Name:: non_base
# Recipe:: ldap
#
# Copyright 2015, NIFTY Corporation
#
# All rights reserved - Do Not Redistribute
#

## LDAPの設定
# 必要パッケージのインストール
%w{openssh-server authconfig pam pam_ldap glibc nscd nss-pam-ldapd}.each do |packages|
  package packages do
    action :install
  end
end

case node[:platform_version][0]
when "7"
  execute "authconfig" do
    command 'authconfig --enableldap --enableldapauth --ldapserver=ldap://acntslv111.ldap.sys.nifty.co.jp,ldap://acntslv112.ldap.sys.nifty.co.jp --ldapbasedn="dc=ldap,dc=sys,dc=nifty,dc=co,dc=jp" --enablemkhomedir --update'
  end
end

# グループ作成
group "nifty" do
  gid 10100
  action :create
end

# hostsにLDAPサーバを追記
execute "hosts" do
  command <<-EOH 
cat cookbooks/non_base/templates/hosts_ldap.erb | tee -a /etc/hosts
EOH
  not_if "grep -c '# LDAP servers' /etc/hosts"
#  notifies :restart, "service[network]"
end

# 各設定ファイルの作成、更新
template "/etc/pam.d/system-auth-OpenLDAP-CentOS#{node[:platform_version][0]}" do
  source "templates/system-auth-OpenLDAP-CentOS#{node[:platform_version][0]}.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '644'
  action :create
#  notifies :restart, "service[nslcd]"
end

file "/etc/pam.d/system-auth" do
  action :delete
  only_if "test -L /etc/pam.d/system-auth"
  not_if "readlink /etc/pam.d/system-auth | grep system-auth-OpenLDAP-CentOS#{node[:platform_version][0]}"
  notifies :create, "link[/etc/pam.d/system-auth]", :immediately
#  notifies :restart, "service[nslcd]"
end

link "/etc/pam.d/system-auth" do
  to "/etc/pam.d/system-auth-OpenLDAP-CentOS#{node[:platform_version][0]}"
  action :nothing
end

template "/etc/pam.d/sshd" do
  source "templates/sshd_for_pam#{node[:platform_version][0]}.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '644'
  action :create
#  notifies :restart, "service[nslcd]"
end

template "/etc/nsswitch.conf" do
  source "templates/nsswitch#{node[:platform_version][0]}.conf.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '644'
  action :create
#  notifies :restart, "service[nslcd]"
end

case node[:platform_version][0]
when "6"
  template "/etc/pam_ldap.conf" do
    source "templates/pam_ldap.conf.erb"
    Encoding.default_external = Encoding::UTF_8
    mode '644'
    action :create
  #  notifies :restart, "service[nslcd]"
  end
end

template "/etc/sudo-ldap.conf" do
  source "templates/sudo-ldap.conf.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '640'
  action :create
  notifies :restart, "service[nslcd]"
end

template "/etc/nslcd.conf" do
  source "templates/nslcd.conf.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '600'
  action :create
#  notifies :restart, "service[nslcd]"
end

# nslcdの自動起動設定
service "nslcd" do
  action [:enable, :restart]
end

# sshdの設定ファイル入れ替え、設定反映
service "sshd" do
  action :nothing
end

template "/etc/ssh/sshd_config" do
  source "templates/sshd_config.erb"
  Encoding.default_external = Encoding::UTF_8
  mode '644'
  action :create
#  notifies :restart, "service[sshd]"
end

service "sshd" do
  action [:enable, :restart]
end

#service "network" do
#  action [:enable, :restart]
#end

# ついでにsshの設定ファイルを修正
file "/etc/ssh/ssh_config" do
  action :edit
  owner "root"
  group "root"
  block do |content|
    content.gsub!(/^#   Port 22/, "Port 14022")
  end
end
