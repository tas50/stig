require 'spec_helper'

# CENTOS6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.13, 6.2.14
# UBUNTU: 9.3.1, 9.3.2, 9.3.5, 9.3.3, 9.3.6, 9.3.7, 9.3.8, 9.3.9, 9.3.10, 9.3.13, 9.3.14

describe file('/etc/ssh/sshd_config') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 600 }
  # CENTOS6: 6.2.2
  # UBUNTU: 9.3.1
  its(:content) { should contain "Protocol 2" }
  # CENTOS6: 6.2.3
  # UBUNTU: 9.3.2
  its(:content) { should contain "LogLevel INFO" }
  # CENTOS: 6.2.5
  # UBUNTU: 9.3.5
  its(:content) { should contain /MaxAuthTries [1-4]/ }
  # CENTOS: 6.2.6
  # UBUNTU: 9.3.6
  its(:content) { should contain "IgnoreRhosts yes" }
  # CENTOS: 6.2.7
  # UBUNTU: 9.3.7
  its(:content) { should contain "HostbasedAuthentication no" }
  # CENTOS: 6.2.8
  # UBUNTU: 9.3.8
  its(:content) { should contain "PermitRootLogin no" }
  # CENTOS: 6.2.9
  # UBUNTU: 9.3.9
  its(:content) { should contain "PermitEmptyPasswords no" }
  # CENTOS: 6.2.10
  # UBUNTU: 9.3.10
  its(:content) { should contain "PermitUserEnvironment no" }
  # CENTOS: 6.2.13
  # UBUNTU: 9.3.13
  its(:content) { should_not contain "AllowUsers" }
  its(:content) { should_not contain "AllowGroups" }
  its(:content) { should contain "DenyUsers bin,daemon,adm,lp,mail,uucp,operator,games,gopher,ftp,nobody,vcsa,rpc,saslauth,postfix,rpcuser,nfsnobody,sshd" }
  its(:content) { should_not contain "DenyGroups" }
  # CENTOS: 6.2.14
  # UBUNTU: 9.3.14
  its(:content) { should contain "Banner /etc/issue.net" }

  # RHEL6: 6.2.11
  its(:content) { should contain "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" }
  
  its(:content) { should contain "ChallengeResponseAuthentication no" }
  its(:content) { should contain "UsePAM yes" }
end
