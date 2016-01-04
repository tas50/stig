require 'spec_helper'

# UBUNTU: 7.4.2, 7.4.3
# CENTOS6: 5.5.2, 5.5.3
describe file('/etc/hosts.allow') do
  it { should be_file }
  it { should be_mode 644 }
end

# UBUNTU: 7.4.4, 7.4.5
# CENTOS6: 5.5.4, 5.5.5
describe file('/etc/hosts.deny') do
  it { should be_file }
  it { should be_mode 644 }
end
describe command(' grep "ALL: ALL" /etc/hosts.deny') do
  its(:stdout) { should match /ALL: ALL/ }
end