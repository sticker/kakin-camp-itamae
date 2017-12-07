# グループ作成
group "oinstall" do
  gid 10202
  groupname "oinstall"
end

# ユーザ作成
user "oracle" do
  uid 10112
  gid "oinstall"
  username "oracle"
  password "oracle"
  shell "/bin/bash"
end

directory "/opt/oracle" do
  action :create
  mode "755"
  owner "oracle"
  group "oinstall"
end

directory "/opt/oracle/product" do
  action :create
  mode "775"
  owner "oracle"
  group "oinstall"
end

package "sudo" do
  action :install
end

execute "install oracle-client" do
  user "oracle"
  command <<-EOH
cd /var/tmp
wget "http://172.26.31.139/share/proxy/alfresco-noauth/api/internal/shared/node/XWfASqZtT2KcWtoll2Bkog/content/OracleDatabase12cRelease1_Client_12.1.0.2.0_for_Linux_64-bit.zip"
wget "http://172.26.31.139/share/proxy/alfresco-noauth/api/internal/shared/node/-OSz0ekdRm-NLMlec65Ivg/content/client_install.rsp"
unzip OracleDatabase12cRelease1_Client_12.1.0.2.0_for_Linux_64-bit.zip
unset ORACLE_BASE
unset ORACLE_HOME
unset ORA_NLS10
unset LD_LIBRARY_PATH
unset ORACLE_SID
./client/runInstaller -silent -noconfig -responseFile /var/tmp/client_install.rsp
EOH
  not_if "ls /opt/oracle/product/client/12.1.0"
end
