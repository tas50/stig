require 'spec_helper'

describe 'stig::proc_hard CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::proc_hard') }

  before do
    stub_command('sysctl -n -e fs.suid_dumpable').and_return(true)
    stub_command('sysctl -n -e net.ipv4.ip_forward').and_return(true)
  end

  it 'creates /etc/security/limits.conf template' do
    expect(chef_run).to create_template('/etc/security/limits.conf').with(
      source: 'limits.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not remove apport package on RHEL' do
    yum_pkg = chef_run.package('apport')
    expect(yum_pkg).to do_nothing
  end

  it 'does not remove whoopsie package on RHEL' do
    yum_pkg = chef_run.package('whoopsie')
    expect(yum_pkg).to do_nothing
  end
end

describe 'stig::proc_hard CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::proc_hard') }

  before do
    stub_command('sysctl -n -e fs.suid_dumpable').and_return(true)
    stub_command('sysctl -n -e net.ipv4.ip_forward').and_return(true)
  end

  it 'creates /etc/security/limits.conf template' do
    expect(chef_run).to create_template('/etc/security/limits.conf').with(
      source: 'limits.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not remove apport package on RHEL' do
    expect(chef_run).to_not remove_package('apport')
  end

  it 'does not remove whoopsie package on RHEL' do
    expect(chef_run).to_not remove_package('whoopsie')
  end
end
