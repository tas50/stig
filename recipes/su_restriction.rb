#
# Cookbook Name:: stig
# Recipe:: su_restriction
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# CENTOS6: 6.5
#
# Description: Restrict access to the su command

if %w{rhel fedora centos}.include?(node["platform"])
  cookbook_file "/etc/pam.d/su" do
    source "etc_pam_d_su_centos"
    owner "root"
    group "root"
    mode 0644
  end
end

if %w{debian ubuntu}.include?(node["platform"])
  cookbook_file "/etc/pam.d/su" do
    source "etc_pam_d_su_ubuntu"
    owner "root"
    group "root"
    mode 0644
  end
end
