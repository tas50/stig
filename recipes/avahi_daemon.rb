# Cookbook Name:: stig
# Recipe:: avahi_daemon
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Manage Avahi daemin
#
# CIS Benchmark Items
# RHEL6:  3.3
# CENTOS6: 3.3
# UBUNTU: 6.2 (avahi-daemon not installed by default)
#
# - Disable AVAHI server.

platform = node['platform']

execute 'chkconfig_avahi-daemon_off' do
  user 'root'
  command '/sbin/chkconfig avahi-daemon off'
  action :run
  only_if "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
  only_if { %w(rhel fedora centos).include? platform }
end

package 'avahi' do
  action :remove
  only_if { %w(rhel fedora centos).include? platform }
end

package 'avahi-daemon' do
  action :purge
  only_if { %w(debian ubuntu).include? platform }
end
