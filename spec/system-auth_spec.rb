require 'spec_helper'

describe 'stig::system-auth' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command("grep -q 'remember=10' /etc/pam.d/system-auth-ac").and_return(false)
    stub_command("test -L /etc/pam.d/system-auth").and_return(false)
  end

  it 'deletes original /etc/pam.d/system-auth' do
    expect(chef_run).to delete_file('/etc/pam.d/system-auth')
  end

  it 'creates /etc/pam.d/system-auth symlink' do
    link = chef_run.link('/etc/pam.d/system-auth')
    expect(link).to link_to('/etc/pam.d/system-auth-ac')
  end

  it 'runs bash script' do
    # Poor test, but ensure that the script runs
    expect(chef_run).to run_bash('update_pass_reuse_in_pam_sysauth')
  end
end
