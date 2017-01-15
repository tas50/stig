require 'spec_helper'

describe 'stig::login_banner' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates /etc/motd file' do
    expect(chef_run).to create_template('/etc/motd').with(
      path: '/etc/motd',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue file' do
    expect(chef_run).to create_template('/etc/issue').with(
      path: '/etc/issue',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue.net file' do
    expect(chef_run).to create_template('/etc/issue.net').with(
      path: '/etc/issue.net',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
