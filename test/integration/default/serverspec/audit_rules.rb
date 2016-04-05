require 'spec_helper'


describe file('/etc/audit/audit.rules') do
  it { should exist }
  it { should be_file }
  it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should contain "-w /etc/group -p wa -k identity" }
  its(:content) { should contain "-w /etc/issue -p wa -k system-locale" }
  its(:content) { should contain "-b 8192" }
  its(:content) { should contain "-f 1" }
  its(:content) { should contain "-D" }
end