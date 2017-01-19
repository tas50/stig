require 'spec_helper'

describe 'stig::rsyslog' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates /etc/rsyslog.conf template' do
    expect(chef_run).to create_template('/etc/rsyslog.conf').with(
      source: 'etc_rsyslog.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes restart_syslog execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('restart_syslog')
  end
end
