
# CENTOS
if %w(rhel fedora centos redhat).include?(os[:family])

  # CENTOS6 1.4.2
  # CENTOS6 1.4.3
  describe file('/etc/selinux/config') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0644' }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('content') { should include('SELINUX=enforcing') }
    its('content') { should include('SELINUXTYPE=targeted') }
  end
  describe command('/usr/sbin/getenforce') do
    its(:stdout) { should match /Enforcing/ }
  end

  # CENTOS6: 1.4.1
  # CENTOS6: 1.5.3
  describe file('/etc/grub2.cfg') do
    it { should exist }
    it { should be_file }
    it { should be_linked_to '/boot/grub2/grub.cfg' }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('content') { should_not include('selinux=0') }
    its('content') { should_not include('enforcing=0') }
    its('content') { should_not include('password --md5') }
  end
  describe file('/boot/grub2/grub.cfg') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0600' }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
  #
  describe command('stat -L -c "%u %g" /etc/grub2.cfg | egrep "0 0"') do
    its(:stdout) { should match /0 0/ }
  end
  # CENTOS6: 1.5.2
  describe command('stat -L -c "%a" /etc/grub2.cfg | egrep ".00"') do
    its(:stdout) { should_not match /^$/ }
  end

  # CENTOS6 1.4.4
  describe package('setroubleshoot') do
    it { should_not be_installed }
  end

  # CENTOS6 1.4.5
  describe package('mcstrans') do
    it { should_not be_installed }
  end

  # TODO- Bad test - Will not always be running on VirtualBox
  # CENTOS6: 1.4.6
  # describe command('ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ":" " " | awk "{ print $NF }"') do
  #   its(:stdout) { should match /^$|VBoxService/ }
  # end

  # CENTOS6: 3.2
if %w(rhel fedora centos redhat).include?(os[:family]) && os[:release][0, 1].to_i  < 7
    describe file('/etc/inittab') do
      it { should exist }
      it { should be_file }
      its('mode') { should cmp '0644' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its('content') { should include('id:3:initdefault:') }
    end
  end
end
