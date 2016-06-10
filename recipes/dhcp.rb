# Cookbook Name:: stig
# Recipe:: dhcp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Remove DHCP Server
#
# CIS Benchmark Items
# RHEL6:  3.5
# CENTOS6: 3.5
# UBUNTU: 6.4

platform = node['platform']

package "dhcp" do
  action :remove
  provider Chef::Provider::Package::Rpm
  only_if { %w{rhel fedora centos}.include? platform }
end

template "/etc/init/isc-dhcp-server.conf" do
  source "etc_init_isc-dhcp-server.conf.erb"
  owner "root"
  group "root"
  only_if { %w{debian ubuntu}.include? platform }
end

template "/etc/init/isc-dhcp-server6.conf" do
  source "etc_init_isc-dhcp-server6.conf.erb"
  owner "root"
  group "root"
  only_if { %w{debian ubuntu}.include? platform }
end
