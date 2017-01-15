require 'spec_helper'

describe 'stig::boot_settings' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command("grep -q 'selinux=0' /etc/grub.conf").and_return(false)
    stub_command("grep -q 'enforcing=0' /etc/grub.conf").and_return(false)
    stub_command("grep -q 'password' /etc/grub.conf").and_return(false)
  end

  it 'creates /etc/sysconfig/init template' do
    expect(chef_run).to create_template('/etc/sysconfig/init').with(
      source: 'etc_sysconfig_init.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/audit/auditd.conf template' do
    expect(chef_run).to create_template('/etc/audit/auditd.conf').with(
      source: 'etc_audit_auditd.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o640
    )
  end
end
