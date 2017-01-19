#
# Cookbook Name:: stig
# Recipe:: tcp_wrappers
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Install TCP Wrappers
#
# CIS Benchmark Items
#
#
# Ubuntu 7.4.1
# CentOS 5.5.1
# Redhat 4.5

package 'tcp_wrappers' if %w(rhel fedora centos).include?(node['platform'])

package 'tcpd' if %w(debian ubuntu).include?(node['platform'])
