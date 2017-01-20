# Cookbook Name:: stig
# Recipe:: proc_hard
# Author: David Blodgett <dblodgett@usgs.gov>
#
# Description: Sets a few policies
#
# TODO: This recipe should probably be refactored into separate recipes for the 1.x.x and 4.x.x items
#
# RHEL6 (2.0.0) : 1.5.1
# RHEL7 (2.0.0) : 1.5.1
# CENTOS6 (2.0.0) : 1.5.1
# CENTOS7 (2.0.0) : 1.5.1
#
# CIS Benchmark Items
# RHEL6:  1.7.1, 1.7.2, 1.7.3, 4.1.1, 4.1.2, 4.2.2, 4.2.3, 4.2.4, 4.2.7, 4.4.2.2
# CENTOS6: 1.6.3, 5.1.1, 5.1.2, 5.2.2, 5.2.3, 5.2.4, 5.2.7, 5.4.1.1, 5.4.1.2
# UBUNTU: 4.1, 4.3, 7.1.1, 7.1.2, 7.2.2, 7.2.3, 7.2.4, 7.2.7, 7.3.1, 7.3.2, 7.3.3
# - Restrict Core Dumps
# - Enable Randomized Virtual Memory Region Placement
# - Disable IP Forwarding
# - Disable Send Packet Redirects
# - Disable ICMP Redirect Acceptance
# - Disable Secure ICMP Redirect Acceptance
# - Log Suspicious Packets
# - Enable RFC-recommended Source Route Validation
# - Disable IPv6 Redirect Acceptance

platform = node['platform']

template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

package 'apport' do
  action :remove
  only_if { %w(debian ubuntu).include? platform }
end

package 'whoopsie' do
  action :remove
  only_if { %w(debian ubuntu).include? platform }
end

include_recipe 'sysctl::apply'

ip_forwarding = node['stig']['network']['ip_forwarding']

send_redirects = node['stig']['network']['packet_redirects']

icmp_redirect_accept = node['stig']['network']['icmp_redirect_accept']

log_suspicious_packets =  node['stig']['network']['log_suspicious_packets']

rfc_source_route_validation = node['stig']['network']['rfc_source_route_validation']

ipv6_redirect_accept = node['stig']['network']['ipv6_redirect_accept']

icmp_all_secure_redirect_accept = node['stig']['network']['icmp_all_secure_redirect_accept']

ipv6_ra_accept = node['stig']['network']['ipv6_ra_accept']

execute 'sysctl_ip_forward' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.ip_forward=#{ip_forwarding}"
  not_if "sysctl -e net.ipv4.ip_forward | grep -q #{ip_forwarding}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_send_redirects' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.all.send_redirects=#{send_redirects}"
  not_if "sysctl -e net.ipv4.ip_forward | grep -q #{send_redirects}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_send_default_redirects' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.default.send_redirects=#{send_redirects}"
  not_if "sysctl -e net.ipv4.conf.default.send_redirects | grep -q #{send_redirects}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_icmp_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.all.accept_redirects=#{icmp_redirect_accept}"
  not_if "sysctl -e net.ipv4.conf.all.accept_redirects | grep -q #{icmp_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_icmp_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.default.accept_redirects=#{icmp_redirect_accept}"
  not_if "sysctl -e net.ipv4.conf.default.accept_redirects | grep -q #{icmp_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_icmp_secure_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.all.secure_redirects=#{icmp_all_secure_redirect_accept}"
  not_if "sysctl -e net.ipv4.conf.all.secure_redirects | grep -q #{icmp_all_secure_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_icmp_secure_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.default.secure_redirects=#{icmp_all_secure_redirect_accept}"
  not_if "sysctl -e net.ipv4.conf.default.secure_redirects | grep -q #{icmp_all_secure_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_log_suspicious_packets' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.all.log_martians=#{log_suspicious_packets}"
  not_if "sysctl -e net.ipv4.conf.all.log_martians | grep -q #{log_suspicious_packets}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_log_suspicious_packets' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.default.log_martians=#{log_suspicious_packets}"
  not_if "sysctl -e net.ipv4.conf.default.log_martians | grep -q #{log_suspicious_packets}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_rfc_source_route_validation' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.all.rp_filter=#{rfc_source_route_validation}"
  not_if "sysctl -e net.ipv4.conf.all.rp_filter | grep -q #{rfc_source_route_validation}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_rfc_source_route_validation' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv4.conf.default.rp_filter=#{rfc_source_route_validation}"
  not_if "sysctl -e net.ipv4.conf.default.rp_filter | grep -q #{rfc_source_route_validation}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_ipv6_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv6.conf.all.accept_redirects=#{ipv6_redirect_accept}"
  not_if "sysctl -e net.ipv6.conf.all.accept_redirects | grep -q #{ipv6_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_ipv6_redirect_accept' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv6.conf.default.accept_redirects=#{ipv6_redirect_accept}"
  not_if "sysctl -e net.ipv6.conf.default.accept_redirects | grep -q #{ipv6_redirect_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_ipv6_router_advertisement' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv6.conf.all.accept_ra=#{ipv6_ra_accept}"
  not_if "sysctl -e net.ipv6.conf.all.accept_ra | grep -q #{ipv6_ra_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_default_ipv6_router_advertisement' do
  user 'root'
  command "/sbin/sysctl -e -w net.ipv6.conf.default.accept_ra=#{ipv6_ra_accept}"
  not_if "sysctl -e net.ipv6.conf.default.accept_ra | grep -q #{ipv6_ra_accept}"
  notifies :run, 'execute[sysctl_commit]', :delayed
end

execute 'sysctl_commit' do
  user 'root'
  command ' /sbin/sysctl -e -p'
  action :nothing
end
