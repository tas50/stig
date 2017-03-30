describe package('aide') do
  it { should be_installed }
end

describe file('/var/lib/aide/aide.db.gz') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe file('/var/lib/aide/aide.db') do
  it { should_not be_file }
end

describe crontab do
  its('commands') { should include '/usr/sbin/aide --check' }
end
