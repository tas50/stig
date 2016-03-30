# Use an MD5 hash for CentOS. Ex: openssl passwd -1 ChangeMe returns: 
# $1$ifTCDC.V$0VpmYkffVbzFkE8ElJrWU/
#
# Use grub-mkpasswd-pbkdf2 for Ubuntu. This is hashed 'ChangeMe':
# grub.pbkdf2.sha512.10000.018CE115164107059077A[... cut for brevity ...]525DE71E3FF5FC734461C6
default['stig']['grub']['hashedpassword'] = ''

# Set hard core to 0 according to CIS 1.6.1
default['stig']['limits'] = [
  {
    '*' => {
      'hard' => 'core 0'
    }
  }
]

# Configure Audit Log Storage Size - In megabytes
default['stig']['auditd']['max_log_file'] = '25' 
# Disable System on Audit Log Full (Not Scored)
default['stig']['auditd']['space_left_action'] = 'email'
default['stig']['auditd']['action_mail_acct'] = 'root'
default['stig']['auditd']['admin_space_left_action'] = 'halt' # YIKES!
# Keep All Auditing Information (Scored)
default['stig']['auditd']['max_log_file_action'] = 'keep_logs'
# Enable Auditing for Processes That Start Prior to auditd (Scored)
default['stig']['auditd']['kernel_audit_grub'] = 'audit=1'

# Removing support for unneeded filesystem types
default['stig']['mount_disable']['cramfs'] = true
default['stig']['mount_disable']['freevxfs'] = true
default['stig']['mount_disable']['jffs2'] = true
default['stig']['mount_disable']['hfs'] = true
default['stig']['mount_disable']['hfsplus'] = true
default['stig']['mount_disable']['squashfs'] = true
default['stig']['mount_disable']['udf'] = true

# Configure Mail Transfer Agent for Local-Only Mode
# If the system is intended to be a mail server, change from 'localhost'
default['stig']['mail_transfer_agent']['inet_interfaces'] = 'localhost'

# Disable Avahi Server
# true / false
default['stig']['network']['zeroconf'] = true

# Disable IP Forwarding
# false = IP forwarding disabled
# true = IP forwarding enabled
default['stig']['network']['ip_forwarding'] = false

# Disable Send Packet Redirects
# false = Disable redirects
# true = Enable redirects
default['stig']['network']['packet_redirects'] = false

# Disable ICMP Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['icmp_redirect_accept'] = false

# Disable Secure ICMP Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['icmp_all_secure_redirect_accept'] = false

# Log Suspicious Packets
# true / false
default['stig']['network']['log_suspicious_packets'] = true

# Enable RFC-recommended Source Route Validation
# true / false
default['stig']['network']['rfc_source_route_validation'] = true

# Disable IPv6 Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['ipv6_redirect_accept'] = false

# Disable IPv6 Router Advertisements
# false = Disable IPv6 router advertisements
# true = Enable IPv6 router advertisements
default['stig']['network']['ipv6_ra_accept'] = false

# Disable IPv6
# false = Do not disable ipv6
# true = Disable ipv6
default['stig']['network']['ipv6_disable'] = true

# Create /etc/hosts.allow
# An array of <net>/<mask> combinations or ['ALL']
default['stig']['network']['hosts_allow'] = ['ALL']

# Create /etc/hosts.deny
# An array of <net>/<mask> combinations or ['ALL']
default['stig']['network']['hosts_deny'] = ['ALL']

# Disable DCCP
# true = disable
# false = enable
default['stig']['network']['disable_dcpp'] = true

# Disable SCTP
# true = disable
# false = enable
default['stig']['network']['disable_sctp'] = true

# Disable RDS
# true = disable
# false = enable
default['stig']['network']['disable_rds'] = true

# Disable TIPC
# true = disable
# false = enable
default['stig']['network']['disable_tipc'] = true

# Disable IPv6
# no = disabled
# yes = enabled
default['stig']['network']['ipv6'] = 'no'

# Configure /etc/rsyslog.conf
# Include rules for logging in array with space separating rule with log location
default['stig']['logging']['rsyslog_rules'] = []
default['stig']['logging']['rsyslog_rules_rhel'] = [
  '*.info;mail.none;authpriv.none;cron.none   /var/log/messages',
  'authpriv.*   /var/log/secure',
  'mail.*   -/var/log/maillog',
  'cron.*   /var/log/cron',
  '*.emerg   *',
  'uucp,news.crit   /var/log/spooler',
  'local7.*    /var/log/boot.log'
]
default['stig']['logging']['rsyslog_rules_debian'] = [
  '*.emerg :omusrmsg:*',
  'mail.* -/var/log/mail',
  'mail.info -/var/log/mail.info',
  'mail.warning -/var/log/mail.warn',
  'mail.err /var/log/mail.err',
  'news.crit -/var/log/news/news.crit',
  'news.err -/var/log/news/news.err',
  'news.notice -/var/log/news/news.notice',
  '*.=warning;*.=err -/var/log/warn',
  '*.crit /var/log/warn',
  '*.*;mail.none;news.none -/var/log/messages',
  'local0,local1.* -/var/log/localmessages',
  'local2,local3.* -/var/log/localmessages',
  'local4,local5.* -/var/log/localmessages',
  'local6,local7.* -/var/log/localmessages'
]

# Configure logrotate
default['logrotate']['global']['/var/log/cron'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}
default['logrotate']['global']['/var/log/maillog'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}
default['logrotate']['global']['/var/log/messages'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}
default['logrotate']['global']['/var/log/secure'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}
default['logrotate']['global']['/var/log/spooler'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}
default['logrotate']['global']['/var/log/spooler'] = {
  'sharedscripts' => 'true',
  'postrotate' => <<-EOF
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  EOF
}


# By default, SELinux is enabled. However, there may be reasons to shut it off
default['stig']['selinux']['enabled'] = true
# Possible values: enforcing, permissive
default['stig']['selinux']['status'] = 'enforcing'
# Possible values: targeted, mls
default['stig']['selinux']['type'] = 'targeted'

# Set LogLevel to INFO
default['stig']['sshd_config']['log_level'] = 'INFO'

#Set SSH MaxAuthTries to 4 or Less
default['stig']['sshd_config']['max_auth_tries'] = 3

# Set SSH IgnoreRhosts to Yes
default['stig']['sshd_config']['ignore_rhosts'] = true

# Set SSH HostbasedAuthentication to No
default['stig']['sshd_config']['host_based_auth'] = false

# Allow SSH Root Login
default['stig']['sshd_config']['permit_root_login'] = false

# Set SSH PermitEmptyPasswords
default['stig']['sshd_config']['permit_empty_passwords'] = false

# Allow Users to Set Environment Options
default['stig']['sshd_config']['allow_users_set_env_opts'] = false

default['stig']['sshd_config']['banner_path'] = '/etc/issue'

# Limit Access via SSH
default['stig']['sshd_config']['deny_users'] = [
  'bin',
  'daemon',
  'adm',
  'lp',
  'mail',
  'uucp',
  'operator',
  'games',
  'gopher',
  'ftp',
  'nobody',
  'vcsa',
  'rpc',
  'saslauth',
  'postfix',
  'rpcuser',
  'nfsnobody',
  'sshd'
]
default['stig']['sshd_config']['deny_groups'] = []
default['stig']['sshd_config']['allow_users'] = []
default['stig']['sshd_config']['allow_groups'] = []


# Limit Password Reuse
# Integer represents the amount of passwords the user is forced to not reuse
default['stig']['system_auth']['pass_reuse_limit'] = 10

# Set Password Expiration Days
default['stig']['login_defs']['pass_max_days'] = 60

# Set Password Change Minimum Number of Days
default['stig']['login_defs']['pass_min_days'] = 1

# Set Password Expiring Warning Days
default['stig']['login_defs']['pass_warn_age'] = 15

# Set the login banner(s)
default['stig']['login_banner']['motd'] = ""
default['stig']['login_banner']['issue'] = default['stig']['login_banner']['motd']
default['stig']['login_banner']['issue_net'] = default['stig']['login_banner']['motd']

# The address the the mail transfer agent should listen on
default["stig"]["mail_transfer_agent"]["inet_interfaces"] = "127.0.0.1"

