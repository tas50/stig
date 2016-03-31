require 'spec_helper'

# CENTOS6: 6.3.4
# UBUNTU: 9.2.3

if ['debian','ubuntu'].include?(host_inventory['platform'])
  describe file('/etc/pam.d/common-password') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    its(:content) { should match /remember=[0-9]+/ }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
	describe file('/etc/pam.d/system-auth') do
    it { should be_file }
    it { should exist }
    it { should be_linked_to 'system-auth-ac' }
  end
  describe file('/etc/pam.d/system-auth-ac') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    its(:content) { should match /remember=[0-9]+/ }
  end
end
