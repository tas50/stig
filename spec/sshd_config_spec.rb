require 'spec_helper'

describe 'stig::sshd_config' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it 'creates /etc/ssh/sshd_config template' do
    expect(chef_run).to create_template('/etc/ssh/sshd_config').with(
      source: 'etc_ssh_sshd_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end
end
