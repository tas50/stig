require 'spec_helper'

describe 'stig::cis' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates /etc/modprobe.d/CIS.conf' do
    expect(chef_run).to create_template('/etc/modprobe.d/CIS.conf').with(
      source: 'etc_modprobe.d_CIS.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
