package "wget" do
  action :install
end

execute "install jdk5" do
  command <<-EOH
cd /usr/local
wget "http://172.26.31.139/share/proxy/alfresco-noauth/api/internal/shared/node/0p1bENaUROSBWFgx-I2aQA/content/jdk-1_5_0_22-linux-amd64.bin" -O jdk-1_5_0_22-linux-amd64.bin
yes | sh jdk-1_5_0_22-linux-amd64.bin
rm jdk-1_5_0_22-linux-amd64.bin
EOH
  not_if "ls /usr/local/jdk1.5.0_22"
end

execute "install apache-ant" do
  command <<-EOH
cd /usr/local
wget "http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.1-bin.tar.gz"
tar zxf apache-ant-1.8.1-bin.tar.gz
rm apache-ant-1.8.1-bin.tar.gz
EOH
  not_if "ls /usr/local/apache-ant-1.8.1"
end
