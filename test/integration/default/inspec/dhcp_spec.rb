
# UBUNTU: 6.4
if %w(debian ubuntu).include?(os['family'])
  describe command('initctl show-config isc-dhcp-server | grep start') do
    its(:stdout) { should_not match /start/ }
  end
  describe command('initctl show-config isc-dhcp-server6 | grep start ') do
    its(:stdout) { should_not match /start/ }
  end
end

# CENTOS6: 3.5
if %w(redhat fedora centos rhel).include?(os['family'])
  describe package('dhcp') do
    it { should_not be_installed }
  end
end
