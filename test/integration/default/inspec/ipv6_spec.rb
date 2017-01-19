

describe file('/etc/sysconfig/network') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/modprobe.d/ipv6.conf') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
