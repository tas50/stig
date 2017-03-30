if %w(redhat fedora centos rhel).include?(os['family'])
  describe service('avahi-daemon') do
    it { should_not be_enabled }
    it { should_not be_installed }
    it { should_not be_running }
  end
end
