# Cookbook Name:: stig
# Recipe:: system-auth
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Sysauth
#
# CIS Benchmark Items
# RHEL6:  6.3.6
# CENTOS6: 6.3.4
# UBUNTU: 9.2.3
#
# - Limit Password Reuse
#
# Checked against CIS RHEL 6 STIG 1.4.0

platform = node['platform']

template "/etc/pam.d/system-auth" do
  source "etc_pam.d_system-auth.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_reuse_limit => node["stig"]["system_auth"]["pass_reuse_limit"]
  )
  only_if { %w{rhel fedora centos}.include? platform }
end

template "/etc/pam.d/common-password" do
  source "etc_pam.d_common-password.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_reuse_limit => node["stig"]["system_auth"]["pass_reuse_limit"]
  )
  only_if { %w{debian ubuntu}.include? platform }
end
