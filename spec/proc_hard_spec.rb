require "spec_helper"

describe "stig::proc_hard" do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it "creates /etc/security/limits.conf template" do
    expect(chef_run).to create_template("/etc/security/limits.conf").with(
      source: "limits.conf.erb",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end

  it "creates /etc/sysctl.conf template" do
    expect(chef_run).to create_template("/etc/sysctl.conf").with(
      source: "sysctl.conf.erb",
      owner: "root",
      group: "root",
      mode: 0644
    )
  end

  it 'excludes sysctl_send_redirects execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_send_redirects')
  end

  it 'excludes sysctl_icmp_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_icmp_redirect_accept')
  end

  it 'excludes sysctl_icmp_secure_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_icmp_secure_redirect_accept')
  end

  it 'excludes sysctl_log_suspicious_packets execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_log_suspicious_packets')
  end

  it 'excludes sysctl_rfc_source_route_validation execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_rfc_source_route_validation')
  end

  it 'excludes sysctl_ipv6_redirect_accept execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_ipv6_redirect_accept')
  end

  it 'excludes sysctl_ipv4_flush execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('sysctl_ipv4_flush')
  end
end
