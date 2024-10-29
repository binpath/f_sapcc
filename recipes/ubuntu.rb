#
# Cookbook:: f_sapcc
# Recipe:: ubuntu
#
# Copyright:: 2024, The Authors, All Rights Reserved.


  # Update the apt package index
  execute 'apt update' do
    command 'apt-get update'
    action :run
  end

  # Upgrade installed packages
  execute 'apt upgrade' do
    command 'apt-get -y upgrade'
    action :run
  end

  # Install dependencies
  package 'software-properties-common' do
    action :install
  end

  package 'unzip' do
    action :install
  end
  

# SAP JAVA AND JVM 

# Download sap jvm
remote_file "/tmp/#{node['sapjvm']['file']}" do
  owner 'root'
  group 'root'
  mode '0644'
  source "https://s3.amazonaws.com/#{node['aws']['s3']}/#{node['sapjvm']['file']}"
  not_if { ::File.exist?('/opt/sapjvm') }
end

# unzip sap jvm
execute 'unzip-sapjvm' do
  command "unzip /tmp/#{node['sapjvm']['file']} -d /opt/sapjvm"
  action :run
  not_if { ::File.exist?('/opt/sapjvm') }
  # notifies :install, "package[com.sap.scc-ui]", :immediately
end

javaHomeFolder = "/opt/sapjvm/sapjvm_8"
jdkFolder = "#{javaHomeFolder}/bin"

bash "update-alternatives java" do
	action :run
	code <<-EOH
	  update-alternatives --install "/usr/bin/java" "java" "#{jdkFolder}/java" 1
	  update-alternatives --set java #{jdkFolder}/java
	EOH
	not_if { ::File.exist?('/usr/bin/java') }
end

ENV['JAVA_HOME'] = '/opt/sapjvm/sapjvm_8'

# SAP CLOUD CONNECTOR
remote_file "/tmp/#{node['sapcc']['file']}" do
  source "https://s3.amazonaws.com/#{node['aws']['s3']}/#{node['sapcc']['file']}"
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exist?('/opt/sapcc') }
end

directory '/opt/sapcc' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::File.directory?('/opt/sapcc') }
  notifies :run, "execute[tar-sapcc]", :immediately
end

execute 'tar-sapcc' do
  command "tar -xzof /tmp/#{node['sapcc']['file']} -C /opt/sapcc"
  action :nothing
  not_if { ::File.exist?('/opt/sapcc/bin') }
  # notifies :install, "package[com.sap.scc-ui]", :immediately
end

# execute "start cloud connectot" do
#   cwd '/opt/sapcc'
#   command "JAVA_HOME='/opt/sapjvm/sapjvm_8' ./go.sh"
# end

# execute 'daemon-install-sapcc' do
#   cwd '/opt/sapcc/'
#   command "go.sh reinstallSystemd"
#   action :nothing
#   not_if { ::File.exist?('/opt/sapcc/bin') }
#   # notifies :install, "package[com.sap.scc-ui]", :immediately
# end


# service 'scc_daemon' do
#   action [:start, :enable]
# end
