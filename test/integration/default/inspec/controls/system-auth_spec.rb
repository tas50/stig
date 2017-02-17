

# CENTOS6: 6.3.4
# UBUNTU: 9.2.3

if %w(debian ubuntu).include?(os['family'])
  describe file('/etc/pam.d/common-password') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its(:content) { should match /remember=[0-9]+/ }
  end
end

if %w(redhat fedora centos rhel).include?(os['family'])

  describe file('/etc/pam.d/password-auth') do
    it { should be_file }
    it { should exist }
    it { should be_linked_to '/etc/pam.d/password-auth-ac' }
  end
  describe file('/etc/pam.d/password-auth-ac') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its(:content) { should match /remember=[0-9]+/ }
  end

  describe file('/etc/pam.d/password-auth') do
    it { should be_file }
    it { should exist }
    it { should be_linked_to '/etc/pam.d/password-auth-ac' }
  end
  describe file('/etc/pam.d/password-auth-ac') do
    it { should be_file }
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its(:content) { should match /remember=[0-9]+/ }
  end
end
