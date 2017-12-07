package "openssh-server" do
  action :install
end

service "sshd" do
  action [:enable, :start]
end
