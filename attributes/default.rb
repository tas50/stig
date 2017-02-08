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
      'hard' => 'core 0'
    }
  }
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
  '-w /etc/sudoers -p wa -k actions'
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

# Specifies whether TCP forwarding is permitted. Allowed values:
# 'yes', 'all', 'no', 'local', 'remote'
# Default: 'yes'
default['stig']['sshd_config']['allow_tcp_forwarding'] = 'yes'

# Specifies the authentication methods that must be successfully completedfor a
# user to be granted access.This option must be followed by one or more comma-separated
# lists ofauthentication method names.Successful authentication requires completion
# of every method in at leastone of these lists.
# This option is only available for SSH protocol 2
default['stig']['sshd_config']['authentication_methods'] = %w()

# Specifies a program to be used to look up the user's public keys.
default['stig']['sshd_config']['authorized_keys_command'] = ''
# Specifies the user under whose account the AuthorizedKeysCommand is run.
# It is recommended to use a dedicated user that has no other role on the host
# than running authorized keys commands.
default['stig']['sshd_config']['authorized_keys_command_user'] = ''

# Specifies the file that contains the public keys that can be usedfor user authentication.
# The format is described in the AUTHORIZED_KEYS FILE FORMAT section ofsshd.
# AuthorizedKeysFile may contain tokens of the form %T which are substituted
# during connectionsetup.The following tokens are defined: %% is replaced by a
# literal '%',%h is replaced by the home directory of the user being authenticated,
# and %u is replaced by the username of that user.
# After expansion, AuthorizedKeysFile is taken to be an absolute path or one
# relative to the user's homedirectory.
default['stig']['sshd_config']['authorized_keys_file'] = '.ssh/authorized_keys'

# Specifies the user under whose account the AuthorizedKeysCommand is run.
default['stig']['sshd_config']['authorized_keys_command_run_as'] = ''

# Specifies a file that lists principal names that are accepted forcertificate
# authentication. When using certificates signed by a key listed in TrustedUserCAKeys
# this file lists names, one of which must appear in the certificate for it to
# be accepted for authentication. Names are listed one per line preceded by key
# options (as described in AUTHORIZED_KEYS FILE FORMAT in sshd).Empty lines and
# comments starting with`#'are ignored.
# AuthorizedPrincipalsFile may contain tokens of the form %T which are substituted
# during connection setup. The following tokens are defined: %% is replaced by a
# literal '%',%h is replaced by the home directory of the user being authenticated,
# and %u is replaced by the username of that user. After expansion, AuthorizedPrincipalsFile
# is taken to be an absolute path or one relative to the user's home directory.
# The default is 'none' i.e. not to use a principals file - in this case,
# the username of the user must appear in a certificate's principals list for it
# to beaccepted. Note that AuthorizedPrincipalsFile is only used when authentication
# proceeds using a CA listed in TrustedUserCAKeys and is not consulted for
# certification authorities trusted via ~/.ssh/authorized_keys though the
# principals=key option offers a similar facility (seesshd for details).
default['stig']['sshd_config']['authorized_principals_file'] = 'none'

# Specifies the pathname of a directory to chroot to after authentication. All
# components of the pathname must be root-owned directories that are not writable
# by any other user or group. After the chroot, sshd changes the working directory
# to the user's home directory. The pathname may contain the following tokens
# that are expanded at runtime oncethe connecting user has been authenticated:
# %% is replaced by a literal '%',%h is replaced by the home directory of the user
# being authenticated, and %u is replaced by the username of that user.
# The ChrootDirectory must contain the necessary files and directories to support
# the user's session. For an interactive session this requires at least a shell,
# typically sh, and basic/devnodes such as null, zero, stdin, stdout, stderr, arandom
# and tty devices. For file transfer sessions using 'sftp' no additional configuration
# of the environment is necessary if thein-process sftp server is used, though
# sessions which use logging do require/dev/log inside the chroot directory
# The default is not to chroot
default['stig']['sshd_config']['chroot_directory'] = 'none'

# Specifies the ciphers allowed.  Multiple ciphers must be comma-
#  separated.  If the specified value begins with a `+' character,
#  then the specified ciphers will be appended to the default set
#  instead of replacing them.
# See: https://www.freebsd.org/cgi/man.cgi?query=sshd_config&sektion=5#end
default['stig']['sshd_config']['ciphers'] = 'aes128-ctr,aes192-ctr,aes256-ctr'

# Sets the number of client alive messages which may besent without sshd receiving
# any messages back from the client. If this threshold is reached while client alive
# messages are being sent, sshd will disconnect the client, terminating the session.
# It is important to note that the use of client alive messages is very different
# from TCPKeepAlive. The client alive messages are sent through the encrypted channel
# and therefore will not be spoofable. The TCP keepalive option enabled by TCPKeepAlive
# is spoofable. The client alive mechanism is valuable when the client orserver depend
# on knowing when a connection has become inactive.
# If ClientAliveInterval is set to 15, and ClientAliveCountMax is left at the default,
# unresponsive SSH clients will be disconnected after approximately 45 seconds.
# This option applies to protocol version 2 only.
# The default value is 3.
default['stig']['sshd_config']['client_alive_count_max'] = 3

# Sets a timeout interval in seconds after which if no data has been received from
# the client, sshd will send a message through the encrypted channel to request
# a response from the client. The default is 0, indicating that these messages
# will not be sent to the client. This option applies to protocol version 2 only.
default['stig']['sshd_config']['client_alive_interval'] = 0

# Specifies whether compression is allowed, or delayed until the user has authenticated
# successfully. The argument must be 'yes' 'delayed' or 'no' The default is 'delayed'
default['stig']['sshd_config']['compression'] = 'delayed'

# Forces the execution of the command specified by ForceCommand ignoring any command
# supplied by the client and ~/.ssh/rc if present. The command is invoked by using
# the user's login shell with the -c option. This applies to shell, command, or
# subsystem execution. It is most useful inside a Matchblock. The command originally
# supplied by the client is available in the SSH_ORIGINAL_COMMAND environment variable.
# Specifying a command of 'internal-sftp' will force the use of an in-process sftp
# server that requires no supportfiles when used with ChrootDirectory
default['stig']['sshd_config']['force_command'] = ''

# Specifies whether remote hosts are allowed to connect to ports forwarded for the
# client. By default, sshd binds remote port forwardings to the loopback address.
# This prevents other remote hosts from connecting to forwarded ports. GatewayPorts
# can be used to specify that sshd should allow remote port forwardings to bind
# to non-loopback addresses, thus allowing other hosts to connect. The argument
# may be 'no' to force remote port forwardings to be available to the local host
# only, 'yes' to force remote port forwardings to bind to the wildcard address,
# or 'clientspecified' to allow the client to select the address to which the
# forwarding is bound. The default is 'no'
default['stig']['sshd_config']['gateway_ports'] = 'no'

# Specifies whether user authentication based on GSSAPI is allowed.
# The default is 'no' Note that this option applies to protocol version 2 only.
default['stig']['sshd_config']['gss_api_authentication'] = 'no'

# Specifies whether key exchange based on GSSAPI is allowed. GSSAPI key exchange
# doesn't rely on ssh keys to verify host identity. The default is 'no'.
# Note that this option applies to protocol version 2 only.
default['stig']['sshd_config']['gss_api_key_exchange'] = 'no'

# Controls whether the user's GSSAPI credentials should be updated following a
# successful connection rekeying. This option can be used to accepted renewed or
# updated credentials from a compatible client.
default['stig']['sshd_config']['gss_api_store_credentials_on_rekey'] = 'no'

# Determines whether to be strict about the identity of the GSSAPI acceptor a client
# authenticates against. If 'yes' (true) then the client must authenticate against
# the host service on the current hostname. If 'no' (false) then the client may
# authenticate against any service key stored in the machine's default store.
# This facility is provided to assist with operation on multi homed machines.
# The default is 'yes'. Note that this option applies only to protocol version 2
# GSSAPI connections, and setting it to 'no' may only work with recent Kerberos
# GSSAPI libraries.
default['stig']['sshd_config']['gss_api_strict_acceptor_check'] = 'yes'

# Specifies whether to automatically destroy the user's credentials cache on logout.#
# Note that this option applies to protocol version 2 only.
default['stig']['sshd_config']['gss_cleanup_credentials'] = 'yes'

# Specifies whether rhosts or /etc/hosts.equiv authentication
# together with successful public key client host authentication is allowed
# (host-based authentication).
# This option is similar to RhostsRSAAuthentication and applies to protocol version
# 2 only.
default['stig']['sshd_config']['host_based_auth'] = 'no'

# Specifies whether or not the server will attempt to perform a reversename lookup
# when matching the name in the ~/.shosts ~/.rhosts and/etc/hosts.equiv files
# during HostbasedAuthentication. A setting of 'yes' means that sshd uses the
# name supplied by the client rather than attempting to resolve the name from
# the TCP connection itself. The default is 'no' (false)
default['stig']['sshd_config']['host_based_uses_name_from_packet_only'] = 'no'

# Specifies a file containing a public host certificate. The certificate's public
# key must match a private host key already specified by HostKey. The default
# behaviour of sshd is not to load any certificates.
default['stig']['sshd_config']['host_certificate'] = ''

# Specifies a file containing a private host keyused by SSH. The default is
# /etc/ssh/ssh_host_key for protocol version 1, and
# /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_ecdsa_key and /etc/ssh/ssh_host_rsa_key
# for protocol version 2. Note that sshd will refuse to use a file if it is
# group/world-accessible. It is possible to have multiple host key files. 'rsa1'
# keys are used for version 1 and 'dsa' 'ecdsa' or 'rsa' are used for version 2
# of the SSH protocol.
default['stig']['sshd_config']['host_key'] = %w(
  /etc/ssh/ssh_host_key
  /etc/ssh/ssh_host_rsa_key
  /etc/ssh/ssh_host_dsa_key
)

# Specifies that .rhosts and .shosts files will not be used in RhostsRSAAuthenticationorHostbasedAuthentication
# /etc/hosts.equiv and /etc/ssh/shosts.equiv are still used. The default is 'yes' (true)
default['stig']['sshd_config']['ignore_rhosts'] = 'yes'

# Specifies whether sshd should ignore the user's ~/.ssh/known_hosts during
# RhostsRSAAuthenticationorHostbasedAuthentication. The default is 'no' (false)
default['stig']['sshd_config']['ignore_user_known_hosts'] = 'no'

# Specifies whether the password provided by the user for
# PasswordAuthentication will be validated through the Kerberos
# KDC.  To use this option, the server needs a Kerberos servtab
# which allows the verification of the KDC's identity. Default is
# 'no' (false)
default['stig']['sshd_config']['kerberos_authentication'] = 'no'

# If set then if password authentication through Kerberos fails then the password
# will be validated via any additional local mechanism such as /etc/passwd.
# Default is 'yes' (true)
default['stig']['sshd_config']['kerberos_or_local_passwd'] = 'yes'

# Specifies whether to automatically	destroy	the user's ticket cache file on logout.
# Default is 'yes' (true)
default['stig']['sshd_config']['kerberos_ticket_cleanup'] = 'yes'

# Specifies whether to look at .k5login file for user's aliases
default['stig']['sshd_config']['kerberos_use_kuserok'] = 'yes'

# In protocol version 1, the	ephemeral server key is	automatically
# regenerated after this many seconds (if it	has been used).	 The
# purpose of	regeneration is	to prevent decrypting captured sessions by
# later breaking into the machine and stealing the keys.
# The key is	never stored anywhere.	If the value is	0, the key is
# never regenerated.	 The default is	3600 (seconds).
default['stig']['sshd_config']['key_regeneration_interval'] = 3600

# The server disconnects after this time if the user has not	successfully logged
# in.  If the value	is 0, there is no time limit. The default is 120 seconds.
default['stig']['sshd_config']['login_grace_time'] = 120

# Specifies the port	number that sshd listens on.  The default is
# 22.  Multiple options of this type are permitted
default['stig']['sshd_config']['port'] = %w(22)

# Specifies whether sshd should print the date and time when the user last logged in.
default['stig']['sshd_config']['print_last_log'] = 'yes'

# Specifies whether sshd should print /etc/motd when	a user logs in
# interactively.  (On some systems it is also printed by the	shell,
# /etc/profile, or equivalent.)
default['stig']['sshd_config']['print_motd'] = 'yes'

# Specifies whether public key authentication is allowed.
# Note that this option	applies	to protocol version 2 only
default['stig']['sshd_config']['pub_key_authentication'] = 'yes'

# Gives the verbosity level that is used when logging messages from
# sshd.  The	possible values	are: QUIET, FATAL, ERROR, INFO,	VER-
# BOSE, DEBUG, DEBUG1, DEBUG2 and DEBUG3.  The default is INFO.
# DEBUG and DEBUG1 are equivalent.  DEBUG2 and DEBUG3 each specify
# higher levels of debugging	output.	 Logging with a	DEBUG level
# violates the privacy of users and is not recommended.
default['stig']['sshd_config']['log_level'] = 'INFO'

# Specifies the available MAC (message authentication code) algorithms.
# The MAC algorithm	is used	in protocol version 2 for data integrity protection.
# Multiple algorithms	must be	comma-separated.
default['stig']['sshd_config']['macs'] = 'hmac-md5,hmac-sha1,hmac-ripemd160,hmac-sha1-96,hmac-md5-96'

# Specifies the maximum number of concurrent	unauthenticated	connections to the
# sshd daemon.  Additional connections will be dropped until authentication succeeds
# or the LoginGraceTime expires for a connection.	The default is 10:30:60.
#
# Alternatively, random early drop can be enabled by	specifying the
# three colon separated values ``start:rate:full'' (e.g.,
# "10:30:60").  sshd	will refuse connection attempts	with a probability of
# 'rate/100' (30%) if there are currently 'start' (10) unauthenticated connections.
# The probability	increases linearly and all connection attempts are refused if
# the number of unauthenticated connections reaches 'full' (60).
default['stig']['sshd_config']['max_startups'] = '10:30:60'

# Set SSH MaxAuthTries to 4 or Less
default['stig']['sshd_config']['max_auth_tries'] = 3

# Specifies the maximum number of open sessions permitted per network connection
default['stig']['sshd_config']['max_sessions'] = 10

# Allow SSH Root Login
default['stig']['sshd_config']['permit_root_login'] = 'no'

# Set SSH PermitEmptyPasswords
default['stig']['sshd_config']['permit_empty_passwords'] = 'no'

# Specifies whether tun(4) device forwarding is allowed. The argument must be
# 'yes', 'point-to-point' (layer 3), 'ethernet' (layer 2), or 'no'. Specifying
# 'yes' permits both 'point-to-point' and 'ethernet'. The default is 'no'
default['stig']['sshd_config']['permit_tunnel'] = 'no'

# Set SSH PasswordAuthentication
default['stig']['sshd_config']['password_authentication'] = 'yes'

# Specifies whether rhosts or /etc/hosts.equiv authentication
# together with successful RSA host authentication is allowed
# This option applies to	protocol version 1 only.
default['stig']['sshd_config']['rhosts_rsa_authentication'] = 'no'

# Specifies whether pure RSA	authentication is allowed.
# This option applies to	protocol version 1 only.
default['stig']['sshd_config']['rsa_authentication'] = 'no'

# Defines the number	of bits	in the ephemeral protocol version 1
# server key.  The minimum value is 512, and	the default is 768
default['stig']['sshd_config']['server_key_bits'] = 768

# Specifies whether sshd will display the patch level of the binary in the
# identification string. The patch level is set at compile-time.
# The default is 'no' (false). This option applies to protocol version 1 only.
default['stig']['sshd_config']['show_patch_level'] = 'no'

# Specifies whether sshd should check file modes and	ownership of
# the user's files and home directory before	accepting login.  This
# is	normally desirable because novices sometimes accidentally
# leave their directory or files world-writable.
default['stig']['sshd_config']['strict_modes'] = 'yes'

# Configures	an external subsystem (e.g., file transfer daemon).
# Arguments should be a subsystem name and a	command	to execute
# upon subsystem request.  The command sftp-server implements
# the ``sftp'' file transfer	subsystem.  By default no subsystems
# are defined.  Note	that this option applies to protocol version 2
# only.
default['stig']['sshd_config']['subsystem'] = 'sftp	/usr/libexec/openssh/sftp-server'

# Gives the facility	code that is used when logging messages	from
# sshd.  The	possible values	are: DAEMON, USER, AUTH, LOCAL0,
# LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7.  The
# default is	AUTHPRIV.
default['stig']['sshd_config']['syslog_facility'] = 'AUTHPRIV'

# Specifies whether the system should send TCP keepalive messages
# to	the other side.	 If they are sent, death of the	connection or
# crash of one of the machines will be properly noticed.  However,
# this means	that connections will die if the route is down tempo-
# rarily, and some people find it annoying.	On the other hand, if
# TCP keepalives are	not sent, sessions may hang indefinitely on
# the server, leaving 'ghost' users and consuming server
# resources.
#
# The default is 'yes' (true) (to	send TCP keepalive messages), and the
# server will notice	if the network goes down or the	client host
# crashes.  This avoids infinitely hanging sessions.
#
# To	disable	TCP keepalive messages,	the value should be set	to
# 'no' (false).
default['stig']['sshd_config']['tcp_keepalive'] = 'yes'

# Specifies whether sshd should lookup the remote host name and
# check that	the resolved host name for the remote IP address maps
# back to the very same IP address.
default['stig']['sshd_config']['use_dns'] = 'no'

# Specifies whether login is used	for interactive	login sessions.
# The default is 'no' (false).  Note that login	is never used
# for remote	command	execution.  Note also, that if this is
# enabled, X11Forwarding will be disabled because login does not
# know how to handle	xauth cookies.  If UsePrivilegeSeparation
# is	specified, it will be disabled after authentication.
default['stig']['sshd_config']['use_login'] = 'no'

# Specifies whether sshd separates privileges by creating an
# unprivileged child	process	to deal	with incoming network traffic.
# After successful authentication, another process will be created
# that has the privilege of the authenticated user.	The goal of
# privilege separation is to	prevent	privilege escalation by	containing
# any corruption within the unprivileged processes.	The
# default is	'yes' (true).
default['stig']['sshd_config']['use_privilege_separation'] = 'yes'

# Specifies a string	to append to the regular version string	to
# identify OS- or site-specific modifications.
default['stig']['sshd_config']['version_addendum'] = ''

# Specifies the first display number	available for sshd's X11 forwarding.
# This prevents sshd from interfering with	real X11 servers.
default['stig']['sshd_config']['x_11_display_offset'] = 10

# Specifies whether X11 forwarding is permitted.  The argument must
# be	'yes'	(true) or 'no' (false).  The	default	is 'yes'.
#
# When X11 forwarding is enabled, there may be additional exposure
# to	the server and to client displays if the sshd proxy display is
# configured	to listen on the wildcard address (see X11UseLocalhost
# below), however this is not the default.  Additionally, the
# authentication spoofing and authentication	data verification and
# substitution occur	on the client side.  The security risk of
# using X11 forwarding is that the clients X11 display server may
# be	exposed	to attack when the ssh client requests forwarding (see
# the warnings for ForwardX11 in ssh_config).  A system administrator
# may	have a stance in which they want to protect clients
# that may expose themselves	to attack by unwittingly requesting
# X11 forwarding, which can warrant a 'no' setting.
#
# Note that disabling X11 forwarding	does not prevent users from
# forwarding	X11 traffic, as	users can always install their own
# forwarders.  X11 forwarding is automatically disabled if UseLogin
# is	enabled.
default['stig']['sshd_config']['x_11_forwarding'] = 'yes'

# Specifies whether sshd should bind	the X11	forwarding server to
# the loopback address or to	the wildcard address.  By default,
# sshd binds	the forwarding server to the loopback address and sets
# the hostname part of the DISPLAY environment variable to
# 'localhost'.  This prevents remote hosts	from connecting	to the
# proxy display.  However, some older X11 clients may not function
# with this configuration.  X11UseLocalhost may be set to 'no' to
# specify that the forwarding server	should be bound	to the wildcard
# address.  The	argument must be 'yes' (true) or 'no' (false).
default['stig']['sshd_config']['x_11_use_local_host'] = 'yes'

# Specifies the full	pathname of the	xauth program
default['stig']['sshd_config']['x_auth_location'] = ''

# Specifies the file	that contains the process ID of	the sshd daemon
default['stig']['sshd_config']['pid_file'] = '/var/run/sshd.pid'

# Allow Users to Set Environment Options
default['stig']['sshd_config']['allow_users_set_env_opts'] = 'no'

default['stig']['sshd_config']['banner_path'] = '/etc/issue.net'

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

#  Specifies whether ssh-agent(1) forwarding is permitted.
# Note that disabling agent forwarding does not improve security unless users
# are also denied shell access, as they can always install their own forwarders.
default['stig']['sshd_config']['allow_agent_forwarding'] = 'yes'

default['stig']['sshd_config']['allow_users'] = []
default['stig']['sshd_config']['allow_groups'] = []
# Specifies what environment	variables sent by the client will be copied into
# the session's environ
# see: https://www.freebsd.org/cgi/man.cgi?query=environ&sektion=7&apropos=0&manpath=FreeBSD+11.0-RELEASE+and+Ports
default['stig']['sshd_config']['accept_env'] = %w(
  LANG
  LC_CTYPE
  LC_NUMERIC
  LC_TIME
  LC_COLLATE
  LC_MONETARY
  LC_MESSAGES
  LC_PAPER
  LC_NAME
  LC_ADDRESS
  LC_TELEPHONE
  LC_MEASUREMENT
  LC_IDENTIFICATION
  LC_ALL
  LANGUAGE XMODIFIERS
)
# Specifies which address family should be used by sshd. Valid arguments are:
# 'any', 'inet' (use IPv4 only), or 'inet6' (use IPv6 only). The default is 'any'
default['stig']['sshd_config']['address_family'] = 'any'

# Specifies the local addresses sshd(8) should listen on.  The fol-
# lowing forms may be used:
#
# ListenAddress host|IPv4_addr|IPv6_addr
# ListenAddress host|IPv4_addr:port
# ListenAddress [host|IPv6_addr]:port
#
# If	port is	not specified, sshd will listen	on the address and all
# Port options specified.  The default is to	listen on all local
# addresses.	 Multiple ListenAddress	options	are permitted.
default['stig']['sshd_config']['listen_address'] = %w(0.0.0.0)

# Specifies the protocol versions sshd supports. (String), Default: 2
default['stig']['sshd_config']['protocol'] = '2'

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
