require 'spec_helper'

describe 'stig::proc_hard' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'includes the `sysctl::apply` recipe' do
    expect(chef_run).to include_recipe('sysctl::apply')
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
