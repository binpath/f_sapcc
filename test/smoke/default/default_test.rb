# # encoding: utf-8

# Inspec test for recipe f_sapcc::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


# https://tools.hana.ondemand.com/additional/sapjvm-8.1.035-linux-x64.rpm
describe file('/tmp/sapjvm-8.1.035-linux-x64.rpm') do
 it { should exist }
end

# sapjvm_8-1.035-1.x86_64
describe package("sapjvm_8") do
	it { is_expected.to be_installed }
	its('version') { should eq '1.039-1' }
end

describe file('/usr/java/sapjvm_8_latest/') do
 it { should exist }
 it { should be_directory }
end

describe file('/usr/bin/java') do
 it { should exist }
 it { should be_executable }
end

describe command("awk '/MemTotal/ {print $2}' /proc/meminfo") do
  its('stdout.strip.to_i') { should be >= 4042004 }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

describe file('/opt/sapcc/com.sap.scc-ui-2.11.1-2.x86_64.rpm') do
 it { should exist }
end

describe package("com.sap.scc-ui") do
	it { is_expected.to be_installed }
	its('version') { should eq '2.11.1-2' }
end

describe port(8443) do
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end


control 'Firewall' do
  impact 1.0
  title 'Servicio Firewall'
  desc 'Servicio Firewall'

  describe service('firewalld') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  # describe file('/etc/sysctl.conf') do
  #   it { should exist }
  #   it { should be_file }
  #   it { should be_owned_by 'root' }
  #   its('content') { should match /net.ipv6.conf.all.disable_ipv6=1/ }
  # end

  describe command('sysctl -a | grep net.ipv6.conf.all.disable_ipv6') do
    its('stdout') { should match /net.ipv6.conf.all.disable_ipv6 = 1/ }
    its('exit_status') { should eq 0 }
  end

end
