require 'spec_helper'

describe 'stig::dhcp' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'removes DHCP' do
    expect(chef_run).to remove_package('dhcp')
  end
end
