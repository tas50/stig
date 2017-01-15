# Use an MD5 hash for CentOS. Ex: openssl passwd -1 ChangeMe returns:
# $1$ifTCDC.V$0VpmYkffVbzFkE8ElJrWU/
#
# Use grub-mkpasswd-pbkdf2 for Ubuntu. This is hashed 'ChangeMe':
# grub.pbkdf2.sha512.10000.018CE115164107059077A[... cut for brevity ...]525DE71E3FF5FC734461C6
default['stig']['grub']['hashedpassword'] = ''

# Set hard core to 0 according to CIS 1.5.1
default['stig']['limits'] = [
  {
    '*' => {
      'hard' => 'core 0',
    },
  },
]

# See http://man7.org/linux/man-pages/man5/auditd.conf.5.html
default['stig']['auditd']['log_file'] = '/var/log/audit/audit.log'
default['stig']['auditd']['log_format'] = 'RAW'
default['stig']['auditd']['log_group'] = 'root'
default['stig']['auditd']['priority_boost'] = '4'
default['stig']['auditd']['flush'] = 'INCREMENTAL'
default['stig']['auditd']['freq'] = '20'
default['stig']['auditd']['num_logs'] = '5'
default['stig']['auditd']['disp_qos'] = 'lossy'
default['stig']['auditd']['dispatcher'] = '/sbin/audispd'
default['stig']['auditd']['name_format'] = 'NONE'
default['stig']['auditd']['max_log_file'] = '25'
default['stig']['auditd']['max_log_file_action'] = 'keep_logs'
default['stig']['auditd']['space_left'] = '75'
default['stig']['auditd']['space_left_action'] = 'email'
default['stig']['auditd']['action_mail_acct'] = 'root'
default['stig']['auditd']['admin_space_left'] = '50'
default['stig']['auditd']['admin_space_left_action'] = 'halt'
default['stig']['auditd']['disk_full_action'] = 'SUSPEND'
default['stig']['auditd']['disk_error_action'] = 'SUSPEND'
default['stig']['auditd']['tcp_listen_queue'] = '5'
default['stig']['auditd']['tcp_max_per_addr'] = '1'
default['stig']['auditd']['tcp_client_ports'] = '1024-65535'
default['stig']['auditd']['use_libwrap'] = 'yes'
default['stig']['auditd']['tcp_client_max_idle'] = '0'
default['stig']['auditd']['enable_krb5'] = 'no'
default['stig']['auditd']['krb5_principal'] = 'auditd'
default['stig']['auditd']['krb5_key_file'] = ''
default['stig']['auditd']['distribute_network'] = 'no'

# Specific to creating ruleset
default['stig']['auditd']['buffer'] = '8192'
default['stig']['auditd']['failure_mode'] = '1'
default['stig']['auditd']['rules'] = [
  '-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change',
  '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change',
  '-a always,exit -F arch=b32 -S clock_settime -F a0=0 -k time-change',
  '-a always,exit -F arch=b64 -S clock_settime -F a0=0 -k time-change',
  '-w /etc/localtime -p wa -k time-change',
  '-w /etc/group -p wa -k identity',
  '-w /etc/passwd -p wa -k identity',
  '-w /etc/gshadow -p wa -k identity',
  '-w /etc/shadow -p wa -k identity',
  '-w /etc/security/opasswd -p wa -k identity',
  '-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale',
  '-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale',
  '-w /etc/issue -p wa -k system-locale',
  '-w /etc/issue.net -p wa -k system-locale',
  '-w /etc/hosts -p wa -k system-locale',
  '-w /etc/sysconfig/network -p wa -k system-locale',
  '-w /etc/selinux/ -p wa -k MAC-policy',
  '-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod',
  '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access',
  '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access',
  '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access',
  '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access',
  '-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged',
  '-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k export',
  '-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k export',
  '-w /etc/sudoers -p wa -k actions',
]

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
default['stig']['network']['ip_forwarding'] = 0
default['sysctl']['params']['net.ipv4.ip_forward'] = node['stig']['network']['ip_forwarding']

# Disable Send Packet Redirects
# false = Disable redirects
# true = Enable redirects
default['stig']['network']['packet_redirects'] = 0
default['sysctl']['params']['net.ipv4.conf.all.send_redirects'] = node['stig']['network']['packet_redirects']
default['sysctl']['params']['net.ipv4.conf.default.send_redirects'] = node['stig']['network']['packet_redirects']

# Disable ICMP Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['icmp_redirect_accept'] = 0
default['sysctl']['params']['net.ipv4.conf.all.accept_redirects'] = node['stig']['network']['icmp_redirect_accept']
default['sysctl']['params']['net.ipv4.conf.default.accept_redirects'] = node['stig']['network']['icmp_redirect_accept']

# Log Suspicious Packets
# true / false
default['stig']['network']['log_suspicious_packets'] = 1
default['sysctl']['params']['net.ipv4.conf.all.log_martians'] = node['stig']['network']['log_suspicious_packets']
default['sysctl']['params']['net.ipv4.conf.default.log_martians'] = node['stig']['network']['log_suspicious_packets']

# Enable RFC-recommended Source Route Validation
# true / false
default['stig']['network']['rfc_source_route_validation'] = 1
default['sysctl']['params']['net.ipv4.conf.all.rp_filter'] = node['stig']['network']['rfc_source_route_validation']
default['sysctl']['params']['net.ipv4.conf.default.rp_filter'] = node['stig']['network']['rfc_source_route_validation']

# Disable IPv6 Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['ipv6_redirect_accept'] = 0
default['sysctl']['params']['net.ipv6.conf.all.accept_redirects'] = node['stig']['network']['ipv6_redirect_accept']
default['sysctl']['params']['net.ipv6.conf.default.accept_redirects'] = node['stig']['network']['ipv6_redirect_accept']

# Disable Secure ICMP Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default['stig']['network']['icmp_all_secure_redirect_accept'] = 0
default['sysctl']['params']['net.ipv4.conf.all.secure_redirects'] = node['stig']['network']['icmp_all_secure_redirect_accept']
default['sysctl']['params']['net.ipv4.conf.default.secure_redirects'] = node['stig']['network']['icmp_all_secure_redirect_accept']

# Disable IPv6 Router Advertisements
# false = Disable IPv6 router advertisements
# true = Enable IPv6 router advertisements
default['stig']['network']['ipv6_ra_accept'] = 0
default['sysctl']['params']['net.ipv6.conf.all.accept_ra'] = node['stig']['network']['ipv6_ra_accept']
default['sysctl']['params']['net.ipv6.conf.default.accept_ra'] = node['stig']['network']['ipv6_ra_accept']
default['sysctl']['params']['net.ipv6.conf.default.accept_ra'] = node['stig']['network']['ipv6_ra_accept']

# Disable IPv6
# false = Do not disable ipv6
# true = Disable ipv6
default['stig']['network']['ipv6_disable'] = 1
default['sysctl']['params']['net.ipv6.conf.all.disable_ipv6'] = node['stig']['network']['ipv6_disable']
default['sysctl']['params']['net.ipv6.conf.default.disable_ipv6'] = node['stig']['network']['ipv6_disable']
default['sysctl']['params']['net.ipv6.conf.lo.disable_ipv6'] = node['stig']['network']['ipv6_disable']

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
  'local7.*    /var/log/boot.log',
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
  'local6,local7.* -/var/log/localmessages',
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

# Set SSH MaxAuthTries to 4 or Less
default['stig']['sshd_config']['max_auth_tries'] = 3

# Set SSH IgnoreRhosts to Yes
default['stig']['sshd_config']['ignore_rhosts'] = true

# Set SSH HostbasedAuthentication to No
default['stig']['sshd_config']['host_based_auth'] = false

# Allow SSH Root Login
default['stig']['sshd_config']['permit_root_login'] = false

# Set SSH PermitEmptyPasswords
default['stig']['sshd_config']['permit_empty_passwords'] = false

# Set SSH PasswordAuthentication
default['stig']['sshd_config']['password_authentication'] = true

# Allow Users to Set Environment Options
default['stig']['sshd_config']['allow_users_set_env_opts'] = false

default['stig']['sshd_config']['banner_path'] = '/etc/issue.net'

# Specifies the ciphers allowed.  Multiple ciphers must be comma-
#  separated.  If the specified value begins with a `+' character,
#  then the specified ciphers will be appended to the default set
#  instead of replacing them.
# See: https://www.freebsd.org/cgi/man.cgi?query=sshd_config&sektion=5#end
default['stig']['sshd_config']['ciphers'] = 'aes128-ctr,aes192-ctr,aes256-ctr'

# Specifies whether challenge-response authentication is allowed
default['stig']['sshd_config']['challenge_response_authentication'] = 'no'

default['stig']['sshd_config']['use_pam_auth'] = 'yes'

# Limit Access via SSH
default['stig']['sshd_config']['deny_users'] = %w(
  bin
  daemon
  adm
  lp
  mail
  uucp
  operator
  games
  gopher
  ftp
  nobody
  vcsa
  rpc
  saslauth
  postfix
  rpcuser
  nfsnobody
  sshd
)
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
default['stig']['login_banner']['motd'] = ''
default['stig']['login_banner']['issue'] = default['stig']['login_banner']['motd']
default['stig']['login_banner']['issue_net'] = default['stig']['login_banner']['motd']

# The address the the mail transfer agent should listen on
default['stig']['mail_transfer_agent']['inet_interfaces'] = '127.0.0.1'
