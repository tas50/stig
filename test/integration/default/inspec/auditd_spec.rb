
describe file('/etc/audit') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/audit/auditd.conf') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
