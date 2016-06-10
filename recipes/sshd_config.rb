# Cookbook Name:: stig
# Recipe:: sshd_config
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure SSHd
#
# CIS Benchmark Items
# RHEL6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.13
# CENTOS6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.11, 6.2.13, 6.2.14
# UBUNTU: 9.3.1, 9.3.2, 9.3.3, 9.3.6, 9.3.7, 9.3.8, 9.3.9, 9.3.10, 9.3.13, 9.3.14
#
# - Set LogLevel to INFO
# - Set Permissions on /etc/ssh/sshd_config
# - Set SSH MaxAuthTries to 4 or Less
# - Set SSH IgnoreRhosts to Yes
# - Set SSH HostbasedAuthentication to No
# - Disable SSH Root Login
# - Set SSH PermitEmptyPasswords to No
# - Do Not Allow Users to Set Environment Options
# - Limit Access via SSH

if node["stig"]["sshd_config"]["ignore_rhosts"]
  ignore_rhosts = "yes"
else
  ignore_rhosts = "no"
end

if node["stig"]["sshd_config"]["host_based_auth"]
  host_based_auth = "yes"
else
  host_based_auth = "no"
end

if node["stig"]["sshd_config"]["permit_root_login"]
  permit_root_login = "yes"
else
  permit_root_login = "no"
end

if node["stig"]["sshd_config"]["permit_empty_passwords"]
  permit_empty_passwords = "yes"
else
  permit_empty_passwords = "no"
end

if node["stig"]["sshd_config"]["password_authentication"]
  password_authentication = "yes"
else
  password_authentication = "no"
end

if node["stig"]["sshd_config"]["allow_users_set_env_opts"]
  allow_users_set_env_opts = "yes"
else
  allow_users_set_env_opts = "no"
end

template "/etc/ssh/sshd_config" do
  source "etc_ssh_sshd_config.erb"
  mode 0600
  owner "root"
  group "root"
  variables(
    :log_level => node["stig"]["sshd_config"]["log_level"],
    :max_auth_tries => node["stig"]["sshd_config"]["max_auth_tries"],
    :deny_users => node["stig"]["sshd_config"]["deny_users"],
    :deny_groups => node["stig"]["sshd_config"]["deny_groups"],
    :allow_users => node["stig"]["sshd_config"]["allow_users"],
    :allow_groups => node["stig"]["sshd_config"]["allow_groups"],
    :banner_path => node["stig"]["sshd_config"]["banner_path"],
    :ciphers => node["stig"]["sshd_config"]["ciphers"],
    :challenge_response_authentication => node["stig"]["sshd_config"]["challenge_response_authentication"],
    :use_pam_auth => node["stig"]["sshd_config"]["use_pam_auth"],
    :ignore_rhosts => ignore_rhosts,
    :host_based_auth => host_based_auth,
    :permit_root_login => permit_root_login,
    :permit_empty_passwords => permit_empty_passwords,
    :allow_users_set_env_opts => allow_users_set_env_opts,
    :password_authentication => password_authentication
  )
  notifies :restart, 'service[sshd]', :delayed
end

service 'sshd' do
  action :nothing
end
