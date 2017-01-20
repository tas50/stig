require 'spec_helper'

describe 'stig::sshd_config' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  let(:template) { chef_run.template('/etc/ssh/sshd_config') }

  it 'creates /etc/ssh/sshd_config template' do
    expect(chef_run).to create_template('/etc/ssh/sshd_config').with(
      source: 'etc_ssh_sshd_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
    expect(template).to notify('service[sshd]').delayed
  end

  it 'sets sshd service' do
    sshd_service = chef_run.service('sshd')
    expect(sshd_service).to do_nothing
  end
end
