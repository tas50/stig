#
# Cookbook Name:: stig
# Recipe:: tcp_wrappers
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Install TCP Wrappers

package 'tcp_wrappers' if platform_family?('rhel', 'fedora')

package 'tcpd' if platform_family?('debian')
