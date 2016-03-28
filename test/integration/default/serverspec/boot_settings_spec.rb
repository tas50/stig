require 'spec_helper'

# CENTOS
if ['rhel', 'fedora', 'centos', 'redhat'].include?(os[:family])

  # CENTOS6: 1.4.1
  describe command('grep selinux=0 /etc/grub.conf') do
    its(:stdout) { should match /^$/ }
  end
  describe command('grep enforcing=0 /etc/grub.conf') do
    its(:stdout) { should match /^$/ }
  end
  
  # CENTOS6 1.4.2
  describe command('grep SELINUX=enforcing /etc/selinux/config') do
    its(:stdout) { should match /SELINUX=enforcing/ }
  end
  describe command('/usr/sbin/getenforce') do
    its(:stdout) { should match /Enforcing/ }
  end
  
  # CENTOS6 1.4.3
  describe command('grep SELINUXTYPE=targeted /etc/selinux/config') do
    its(:stdout) { should match /SELINUXTYPE=targeted/ }
  end
  
  # CENTOS6 1.4.4
  describe package('setroubleshoot') do
    it { should_not be_installed }
  end
  
  # CENTOS6 1.4.5
  describe package('mcstrans') do
    it { should_not be_installed }
  end
  
  # CENTOS6: 1.4.6
  describe command('ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ":" " " | awk "{ print $NF }"') do
    its(:stdout) { should match /^$|VBoxService/ }
  end
  
  # CENTOS6: 1.5.1
  describe command('stat -L -c "%u %g" /etc/grub.conf | egrep "0 0"') do
    its(:stdout) { should match /0 0/ }
  end
  
  # CENTOS6: 1.5.2
  describe command('stat -L -c "%a" /etc/grub.conf | egrep ".00"') do
    its(:stdout) { should_not match /^$/ }
  end
  
  # CENTOS6: 1.5.3
  describe command('grep "^password" /etc/grub.conf') do
    its(:stdout) { should_not match /password --md5/ }
  end
  
  # CENTOS6: 1.5.5
  describe command('grep "^PROMPT=" /etc/sysconfig/init | tr -d "\n"') do
    its(:stdout) { should match /PROMPT=no/ }
  end
  
  # CENTOS6: 5.2.1
  describe command('/sbin/sysctl net.ipv4.conf.all.accept_source_route') do
    its(:stdout) { should match /net.ipv4.conf.all.accept_source_route = 0/ }
  end
  describe command('/sbin/sysctl net.ipv4.conf.default.accept_source_route') do
    its(:stdout) { should match /net.ipv4.conf.default.accept_source_route = 0/ }
  end
  
  # CENTOS6: 5.2.2
  describe command('/sbin/sysctl net.ipv4.conf.all.accept_redirects') do
    its(:stdout) { should match /net.ipv4.conf.all.accept_redirects = 0/ }
  end
  describe command('/sbin/sysctl net.ipv4.conf.default.accept_redirects') do
    its(:stdout) { should match /net.ipv4.conf.default.accept_redirects = 0/ }
  end
  
  # CENTOS6: 5.2.3
  describe command('/sbin/sysctl net.ipv4.conf.all.secure_redirects') do
    its(:stdout) { should match /net.ipv4.conf.all.secure_redirects = 0/ }
  end
  describe command('/sbin/sysctl net.ipv4.conf.default.secure_redirects') do
    its(:stdout) { should match /net.ipv4.conf.default.secure_redirects = 0/ }
  end
end

# UBUNTU
if ['debian','ubuntu'].include?(host_inventory['platform'])
  # UBUNTU 3.1
  describe command('stat -c "%u %g" /boot/grub/grub.cfg | egrep "^0 0"') do
    its(:stdout) { should match /0 0/ }
  end
  
  # UBUNTU 3.2
  describe command('stat -L -c "%a" /boot/grub/grub.cfg | egrep ".00" ') do
    its(:stdout) { should_not match /^$/ }
  end
end