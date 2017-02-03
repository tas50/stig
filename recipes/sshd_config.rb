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

sshd_config = node['stig']['sshd_config']

template '/etc/ssh/sshd_config' do
  source 'etc_ssh_sshd_config.erb'
  mode 0o600
  owner 'root'
  group 'root'
  variables(
    port: sshd_config['port'],
    log_level: sshd_config['log_level'],
    max_auth_tries: sshd_config['max_auth_tries'],
    deny_users: sshd_config['deny_users'],
    deny_groups: sshd_config['deny_groups'],
    allow_users: sshd_config['allow_users'],
    allow_groups: sshd_config['allow_groups'],
    banner_path: sshd_config['banner_path'],
    ciphers: sshd_config['ciphers'],
    challenge_response_authentication: sshd_config['challenge_response_authentication'],
    use_pam_auth: sshd_config['use_pam_auth'],
    ignore_rhosts: sshd_config['ignore_rhosts'] ? 'yes' : 'no',
    host_based_auth: sshd_config['host_based_auth'] ? 'yes' : 'no',
    permit_root_login: sshd_config['permit_root_login'] ? 'yes' : 'no',
    permit_empty_passwords: sshd_config['permit_empty_passwords'] ? 'yes' : 'no',
    allow_users_set_env_opts: sshd_config['allow_users_set_env_opts'] ? 'yes' : 'no',
    password_authentication: sshd_config['password_authentication'] ? 'yes' : 'no',
    gss_api_key_exchange: sshd_config['gss_api_key_exchange'] ? 'yes' : 'no',
    gss_cleanup_credentials: sshd_config['gss_cleanup_credentials'] ? 'yes' : 'no'
  )
  notifies :restart, 'service[sshd]', :delayed
end

service 'sshd' do
  action :nothing
end
