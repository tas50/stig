# Cookbook Name:: stig
# Recipe:: avahi_daemon
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Manage Avahi daemon
#
# CIS Benchmark Items
# RHEL6:  3.3
# CENTOS6: 3.3/2.2.3
# UBUNTU: 6.2 (avahi-daemon not installed by default)
#
# - Disable AVAHI server.

platform = node['platform']
major_version = node['platform_version'][0, 1].to_i

execute 'Disable avahi-daemon via chkconfig' do
  user 'root'
  command '/sbin/chkconfig avahi-daemon off'
  action :run
  only_if { platform_family?('rhel', 'fedora') }
  only_if { major_version < 7 }
  only_if "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
end

execute 'Disable avahi-daemon via sysctl' do
  user 'root'
  command '/usr/bin/systemctl disable avahi-daemon'
  action :run
  only_if "systemctl >/dev/null 2>&1 && /usr/bin/systemctl list-unit-files | grep -q 'avahi'"
  not_if "systemctl >/dev/null 2>&1 && /usr/bin/systemctl is-enabled avahi-daemon | grep -q 'disabled'"
  only_if { platform_family?('rhel', 'fedora') }
  only_if { major_version >= 7 }
end

package 'avahi' do
  action :remove
  only_if { platform_family?('rhel', 'fedora') }
end

package 'avahi-daemon' do
  action :purge
  only_if { platform_family?('debian') }
end
