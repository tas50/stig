require 'spec_helper'

describe 'stig::hosts' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it 'creates /etc/hosts.allow template' do
    expect(chef_run).to create_template('/etc/hosts.allow').with(
      source: 'etc_hosts.allow.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/hosts.deny template' do
    expect(chef_run).to create_template('/etc/hosts.deny').with(
      source: 'etc_hosts.deny.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
