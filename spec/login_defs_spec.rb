require 'spec_helper'

describe 'stig::login_defs' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it 'creates /etc/login.defs template' do
    expect(chef_run).to create_template('/etc/login.defs').with(
      source: 'etc_login.defs.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
