require 'spec_helper'

describe 'stig::system-auth' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it 'creates /etc/pam.d/system-auth template' do
    expect(chef_run).to create_template('/etc/pam.d/system-auth').with(
      source: 'etc_pam.d_system-auth.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
