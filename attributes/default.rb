# SAP
default["sapjvm"]["version"] = '8.1.092'

default['sapcc']['file'] = 'sapcc-2.17.1-linux-x64.tar.gz'

# AWS
default['aws']['s3'] = 'gtf-sap-repo'

if platform?('ubuntu')
  default["sapjvm"]["file"] = 'sapjvm-8.1.101-linux-x64.zip'
else
  default["sapjvm"]["file"] = 'sapjvm-8.1.101-linux-x64.rpm'
end

