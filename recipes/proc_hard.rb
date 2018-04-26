# Cookbook Name:: stig
# Recipe:: proc_hard
# Author: David Blodgett <dblodgett@usgs.gov>, Ivan Suftin <isuftin@usgs.gov>
#
# Description: Updates sysctl policies using the third-party sysctl cookbook
# and parameters specific to that cookbook coming from the default attributes.

template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

package 'apport' do
  action :remove
  only_if { platform_family?('debian') }
end

package 'whoopsie' do
  action :remove
  only_if { platform_family?('debian') }
end

node['sysctl']['params'].each do |param, value|
  sysctl_param param do
    key param
    value value
    only_if "sysctl -n -e #{param}"
  end
end
