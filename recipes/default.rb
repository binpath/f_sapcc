#
# Cookbook:: f_sapcc
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

execute 'yum clean all' do
  command 'yum clean all'
  action :run
end

execute 'yum update' do
  command 'yum -y update'
  action :run
end

package 'epel-release' do
  action :install
end

package 'initscripts' do
  action :install
end

# Download sap jvm
# cookbook_file '/tmp/sapjvm-8.1.035-linux-x64.rpm' do
#   source 'sapjvm-8.1.035-linux-x64.rpm'
#   owner 'root'
#   group 'root'
#   mode '0644'
# end

# Download sap jvm
remote_file '/tmp/sapjvm-8.1.035-linux-x64.rpm' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'https://s3.amazonaws.com/cl-nvs-tec-tests/sapjvm-8.1.039-linux-x64.rpm'
end


package 'sapjvm' do
  source '/tmp/sapjvm-8.1.035-linux-x64.rpm'
  action :install
  # notifies :run, "bash[update-alternatives java]", :immediately
end

javaHomeFolder = "/usr/java/sapjvm_8_latest/"
jdkFolder = "#{javaHomeFolder}/bin"

bash "update-alternatives java" do
	action :run
	code <<-EOH
	  update-alternatives --install "/usr/bin/java" "java" "#{jdkFolder}/java" 1
	  update-alternatives --set java #{jdkFolder}/java
	EOH
	not_if { ::File.exist?('/usr/bin/java') }
end

package "unzip" do
  action :install
end

remote_file '/tmp/sapcc-2.11.1-linux-x64.zip' do
  source 'https://s3.amazonaws.com/cl-nvs-tec-tests/sapcc-2.11.1-linux-x64.zip'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'unzip-sapcc' do
  command 'unzip /tmp/sapcc-2.11.1-linux-x64.zip -d /opt/sapcc'
  action :run
  not_if { ::File.exist?('/opt/sapcc') }
  notifies :install, "package[com.sap.scc-ui]", :immediately
end

package 'com.sap.scc-ui' do
  source '/opt/sapcc/com.sap.scc-ui-2.11.1-2.x86_64.rpm'
  action :nothing
  # notifies :run, "bash[update-alternatives java]", :immediately
end

service 'scc_daemon' do
  action [:start, :enable]
end





