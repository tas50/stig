#
# Cookbook Name:: stig
# Recipe:: su_restriction
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# CENTOS6: 6.5
#
# Description: Restrict access to the su command

cookbook_file '/etc/pam.d/su for RHEL' do
  path '/etc/pam.d/su'
  source 'etc_pam_d_su_centos'
  owner 'root'
  group 'root'
  mode '0644'
  only_if { platform_family?('rhel', 'fedora') }
end

cookbook_file '/etc/pam.d/su for Debian' do
  path '/etc/pam.d/su'
  source 'etc_pam_d_su_ubuntu'
  owner 'root'
  group 'root'
  mode '0644'
  only_if { platform_family?('debian') }
end
