require 'spec_helper'

describe 'stig::ipv6' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/modprobe.d/ipv6.conf template' do
    expect(chef_run).to create_template('/etc/modprobe.d/ipv6.conf').with(
      source: 'etc_modprobe.d_ipv6.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'Does not execute chkconfig_ip6tables_off' do
    expect(chef_run).to_not run_execute("/sbin/chkconfig ip6tables off")
  end

end
