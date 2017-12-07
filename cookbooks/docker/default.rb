execute "add yum repo" do
  command <<-EOH
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum update -y
EOH
end

%w{yum-utils device-mapper-persistent-data lvm2 docker-ce}.each do |packages|
  package packages do
    action :install
  end
end

template "/etc/modules-load.d/overlay.conf" do
  source "templates/overlay.conf.erb"
  mode '644'
  action :create
  Itamae.logger.warn "Kernelモジュールに overlay を追加しているため reboot してください。"
end

directory "/etc/docker" do
  mode "700"
  action :create
end

template "/etc/docker/daemon.json" do
  source "templates/daemon.json.erb"
  mode '644'
  action :create
end

service "docker" do
  action [:enable, :restart]
end

execute "docker network create" do
  command <<-EOH
docker network create \
    --driver=bridge \
    --subnet=192.168.43.0/24 \
    dockernet
EOH
  not_if "docker network ls | grep dockernet"
end
