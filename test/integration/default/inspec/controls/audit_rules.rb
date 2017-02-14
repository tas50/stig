
describe file('/etc/audit/audit.rules') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should include('-w /etc/group -p wa -k identity') }
  its('content') { should include('-w /etc/issue -p wa -k system-locale') }
  its('content') { should include('-b 8192') }
  its('content') { should include('-f 1') }
  its('content') { should include('-D') }
end
