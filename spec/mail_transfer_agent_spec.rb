require 'spec_helper'

describe 'stig::mail_transfer_agent' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates /etc/postfix/main.cf' do
    expect(chef_run).to create_template('/etc/postfix/main.cf').with(
      source: 'main.cf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes postfix service due to :nothing guard' do
    expect(chef_run).to_not start_service('postfix')
  end
end
