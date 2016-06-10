STIG Cookbook
=============
Installs and configures the CIS CentOS Linux 6 benchmark.  
These sets of recipes aim to harden the operating system in order to pass all scored CIS benchmarks and optionally all unscored CIS benchmarks.

More information about CIS benchmarks may be found at http://benchmarks.cisecurity.org

Requirements
------------
### Platforms
- CentOS 6.6

### Cookbooks
- logrotate

### Suggests
- auditd, ~> 0.1.8

[Changelog](CHANGELOG.md)
---------

Attributes
----------
- `node['stig']['grub']['hashedpassword']` = The hashed grub password to use. Ex: openssl passwd -1 ChangeMe (String (MD5 Hash))

- `node['stig']['limits']` = A hash of items that go into /etc/security/limits.conf (Array of Hashes of Hashes)

- `node['stig']['auditd']` = See: [Auditd Configuration](http://linux.die.net/man/5/auditd.conf)

- `node['stig']['mount_disable']['cramfs']` = Disable cramfs filesystem (Boolean)
- `node['stig']['mount_disable']['freevxfs']` = Disable freevxfs filesystem (Boolean)
- `node['stig']['mount_disable']['jffs2']` = Disable jffs2 filesystem (Boolean)
- `node['stig']['mount_disable']['hfs']` = Disable hfs filesystem (Boolean)
- `node['stig']['mount_disable']['hfsplus']` = Disable hfsplus filesystem (Boolean)
- `node['stig']['mount_disable']['squashfs']` = Disable squashfs filesystem (Boolean)
- `node['stig']['mount_disable']['udf']` = Disable udf filesystem (Boolean)

- `node['stig']['mail_transfer_agent']['inet_interfaces']` = Configure Mail Transfer Agent for Local-Only Mode - If the system is intended to be a mail server, change from "localhost" (String)

- `node['stig']['network']['zeroconf']` = Disable Avahi Server (true = disabled, false = enabled) (Boolean)

- `node['stig']['network']['ip_forwarding']` = Disable IP Forwarding (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['packet_redirects']` = Disable Send Packet Redirects (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['icmp_redirect_accept']` = Disable ICMP Redirect Acceptance (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['icmp_all_secure_redirect_accept']` = Disable Secure ICMP Redirect Acceptance (true = enabled, false = disabled) (
Boolean)

- `node['stig']['network']['log_suspicious_packets']` = Log Suspicious Packets (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['rfc_source_route_validation']` = Enable RFC-recommended Source Route Validation (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['ipv6_redirect_accept']` = Disable IPv6 Redirect Acceptance (true = enabled, false = disabled) (Boolean)

- `node['stig']['network']['hosts_allow']` = Create /etc/hosts.allow - An array of &lt;net>/&lt;mask> combinations or 'ALL' (Array of String)

- `node['stig']['network']['hosts_deny']` = Create /etc/hosts.deny - An array of &lt;net>/&lt;mask> combinations or 'ALL' (Array of String)

- `node['stig']['network']['disable_dcpp']` = Disable DCCP (true = disable, false = enable) (Boolean)

- `node['stig']['network']['disable_sctp']` = Disable SCTP (true = disable, false = enable) (Boolean)

- `node['stig']['network']['disable_rds']` = Disable RDS (true = disable, false = enable) (Boolean)

- `node['stig']['network']['disable_tipc']` = Disable TIPC (true = disable, false = enable) (Boolean)

- `node['stig']['network']['ipv6']` = Disable IPV6 ("no" = disable, "yes" = enable) (String)

- `node['stig']['logging']['rsyslog_rules']` = Configure /etc/rsyslog.conf - Include rules for logging in array with space separating rule with log location (Array of String)
- `node['stig']['logging']['rsyslog_rules_rhel']` = Configure /etc/rsyslog.conf for RHEL - Include rules for logging in array with space separating rule with log location (Array of String)
- `node['stig']['logging']['rsyslog_rules_debian']` = Configure /etc/rsyslog.conf for Debian - Include rules for logging in array with space separating rule with log location (Array of String)

- `node['stig']['selinux']['enabled']` = By default, SELinux is enabled. However, there may be reasons to shut it off (Boolean)
- `node['stig']['selinux']['status']` = Possible values: enforcing, permissive (String)
- `node['stig']['selinux']['type']` = Possible values: targeted, mls (String)


- `node['stig']['sshd_config']['log_level']` = SSHd log level (String)
- `node['stig']['sshd_config']['max_auth_tries']` = SSHd Max auth tries (Integer)
- `node['stig']['sshd_config']['ignore_rhosts']` = SSHd Ignore rhosts (Boolean)
- `node['stig']['sshd_config']['host_based_auth']` = Set SSH HostbasedAuthentication to No (Boolean)
- `node['stig']['sshd_config']['permit_root_login']` = Allow SSH root login (Boolean)
- `node['stig']['sshd_config']['permit_empty_passwords']` = Allow SSH to permit empty passwords (Boolean)
- `node['stig']['sshd_config']['allow_users_set_env_opts']` = Allow Users to Set Environment Options (Boolean)
- `node['stig']['sshd_config']['banner_path']` = Set SSH login banner path (String)
- `node['stig']['sshd_config']['deny_users']` = List of users to deny SSH login to (Array of String)

- `node['stig']['system_auth']['pass_reuse_limit']` = Limit password reuse - Represents the amount of passwords the user is forced to not reuse (Integer)

- `node['stig']['login_defs']['pass_max_days']` = Password expiration in days (Integer)
- `node['stig']['login_defs']['pass_min_days']` = Minimum wait time, in days, before changing password (Integer)
- `node['stig']['login_defs']['pass_warn_age']` = Number of days before password expires where system begins warning user (Integer)

- `node['stig']['login_banner']['motd']` = Login banner (String)
- `node['stig']['login_banner']['issue']` = Login banner (String)
- `node['stig']['login_banner']['issue_net']` = Login banner (String)

- `node["stig"]["mail_transfer_agent"]["inet_interfaces"]` = The address the the mail transfer agent should listen on (String)

Usage
-----
Simply include the default recipe (stig::default) on an instance that needs to be hardened. May also want to include the auditd recipe (stig::auditd) to set a custom auditd configuration file
 
Authors
-------
- Author:: Ivan Suftin (<isuftin@usgs.gov>)
- Author:: David Blodgett (<dblodgett@usgs.gov>)

License
-------
Unless otherwise noted below, this software is in the public domain because it contains
materials that originally came from the United States Geological Survey, an agency of the
United States Department of Interior. For more information, see the official USGS
copyright policy at: http://www.usgs.gov/visual-id/credit_usgs.html#copyright

More information in [license file](https://github.com/USGS-WSI-COOKBOOKS/stig/blob/master/LICENSE)