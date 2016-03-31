require 'spec_helper'

if ['debian','ubuntu'].include?(host_inventory['platform'])
  describe package('tcpd') do
    it { should be_installed }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  describe package('tcp_wrappers') do
    it { should be_installed }
  end
end
