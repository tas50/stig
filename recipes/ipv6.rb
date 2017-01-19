#
# Cookbook Name:: stig
# Recipe:: ipv6
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Disable IPv6
#
# CIS Benchmark Items
# RHEL6:  4.4.1
# CENTOS6: 5.4
#
# - Disable IPv6 for RHEL

if %w(rhel fedora centos).include?(node['platform'])

  # Install IPTables, turn off Firewalld
  if node['platform'] == 'centos' && node['platform_version'][0, 1].to_i > 6

    package 'iptables-services' do
      notifies :run, 'execute[disable_selinux]', :immediately
      notifies :run, 'execute[mask_firewalld]', :immediately
      notifies :run, 'execute[enable_iptables]', :immediately
      notifies :run, 'execute[enable_ip6tables]', :immediately
      notifies :run, 'execute[stop_firewalld]', :immediately
      notifies :run, 'execute[start_iptables]', :immediately
      notifies :run, 'execute[stop_ip6tables]', :immediately
      notifies :run, 'execute[enable_selinux]', :immediately
    end
    execute 'disable_selinux' do
      command 'setenforce 0'
      user 'root'
      action :nothing
    end

    execute 'mask_firewalld' do
      command 'systemctl mask firewalld'
      user 'root'
      action :nothing
    end

    execute 'enable_iptables' do
      command 'systemctl enable iptables'
      user 'root'
      action :nothing
    end

    execute 'enable_ip6tables' do
      command 'systemctl enable ip6tables'
      user 'root'
      action :nothing
    end

    execute 'stop_firewalld' do
      command 'systemctl stop firewalld'
      user 'root'
      action :nothing
    end

    execute 'start_iptables' do
      command 'systemctl start iptables'
      user 'root'
      action :nothing
    end

    execute 'stop_ip6tables' do
      command 'systemctl stop ip6tables'
      user 'root'
      action :nothing
    end

    execute 'enable_selinux' do
      command 'setenforce 1'
      user 'root'
      action :nothing
    end
  end

  template '/etc/sysconfig/network' do
    source 'etc_sysconfig_network.erb'
    user 'root'
    group 'root'
    mode 0o644
  end

  if node['stig']['network']['ipv6'] == 'no'
    ipv6 = 1
    ipv6onoff = 'off'
  else
    ipv6 = 0
    ipv6onoff = 'on'
  end

  template '/etc/modprobe.d/ipv6.conf' do
    source 'etc_modprobe.d_ipv6.conf.erb'
    user 'root'
    group 'root'
    mode 0o644
    variables(ipv6: ipv6)
    notifies :run, 'execute[chkconfig_ip6tables_off]', :immediately
  end

  execute 'chkconfig_ip6tables_off' do
    user 'root'
    command "/sbin/chkconfig ip6tables #{ipv6onoff}"
    action :nothing
  end
end
