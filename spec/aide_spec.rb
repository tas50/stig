require 'spec_helper'

describe 'stig::aide' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command('crontab -u root -l | grep aide').and_return(false)
  end

  # 1.3.1
  it 'installs the aide package' do
    expect(chef_run).to install_package('aide')
  end

  it 'actually initializes aide' do
    expect(chef_run).to run_execute('init_aide').with(
      user: 'root',
      command: "/usr/sbin/aide --init -B 'database_out=file:/var/lib/aide/aide.db.gz'",
      creates: '/var/lib/aide/aide.db.gz'
    )
  end

  # 1.3.2
  it 'checks for aide on a schedule' do
    expect(chef_run).to create_cron('aide_cron').with(
      command: '/usr/sbin/aide --check',
      minute: '0',
      hour: '5',
      day: '*',
      month: '*'
    )
  end
end
