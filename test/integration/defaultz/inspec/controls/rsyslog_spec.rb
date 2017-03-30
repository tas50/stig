

# CENTOS6: 4.1.3
# UBUNTU: 8.2.3

describe file('/etc/rsyslog.conf') do
  it { should be_file }
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end
