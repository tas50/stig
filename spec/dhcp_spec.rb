require 'spec_helper'

describe 'stig::dhcp' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'removes DHCP' do
    expect(chef_run).to remove_package('dhcp')
  end

  it 'does not create /etc/init/isc-dhcp-server.conf template on CentOS' do
    expect(chef_run).to_not create_template('/etc/init/isc-dhcp-server.conf')
    .with(
      source: 'etc_init_isc-dhcp-server.conf.erb',
      owner: 'root',
      group: 'root'
    )
  end

  it 'does not create /etc/init/isc-dhcp-server6.conf template on CentOS' do
    expect(chef_run).to_not create_template('/etc/init/isc-dhcp-server6.conf')
    .with(
      source: 'etc_init_isc-dhcp-server6.conf.erb',
      owner: 'root',
      group: 'root'
    )
  end
end
