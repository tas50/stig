require 'spec_helper'

describe 'stig::tcp_wrappers' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs tcp_wrappers package' do
    expect(chef_run).to install_package('tcp_wrappers')
  end

end
