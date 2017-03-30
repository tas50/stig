

if %w(debian ubuntu).include?(os['family'])
  describe package('tcpd') do
    it { should be_installed }
  end
end

if %w(redhat fedora centos rhel).include?(os['family'])
  describe package('tcp_wrappers') do
    it { should be_installed }
  end
end
