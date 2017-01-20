require 'spec_helper'

describe 'stig::proc_hard' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_command('sysctl -e net.ipv4.ip_forward | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.default.send_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.all.accept_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.default.accept_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.all.secure_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.default.secure_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.all.log_martians | grep -q 1').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.default.log_martians | grep -q 1').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.all.rp_filter | grep -q 1').and_return(false)
    stub_command('sysctl -e net.ipv4.conf.default.rp_filter | grep -q 1').and_return(false)
    stub_command('sysctl -e net.ipv6.conf.all.accept_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv6.conf.default.accept_redirects | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv6.conf.all.accept_ra | grep -q 0').and_return(false)
    stub_command('sysctl -e net.ipv6.conf.default.accept_ra | grep -q 0').and_return(false)
  end

  it 'creates /etc/security/limits.conf template' do
    expect(chef_run).to create_template('/etc/security/limits.conf').with(
      source: 'limits.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes sysctl_send_redirects execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_send_redirects')
  end

  it 'excludes sysctl_icmp_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_icmp_redirect_accept')
  end

  it 'excludes sysctl_icmp_secure_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_icmp_secure_redirect_accept')
  end

  it 'excludes sysctl_log_suspicious_packets execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_log_suspicious_packets')
  end

  it 'excludes sysctl_rfc_source_route_validation execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_rfc_source_route_validation')
  end

  it 'excludes sysctl_ipv6_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to run_execute('sysctl_ipv6_redirect_accept')
  end

  it 'excludes sysctl_ipv4_flush execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_ipv4_flush')
  end
end
