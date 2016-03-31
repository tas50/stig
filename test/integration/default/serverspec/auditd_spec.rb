require 'spec_helper'

describe file('/etc/audit') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/audit/auditd.conf') do
  it { should exist }
  it { should be_file }
  it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end