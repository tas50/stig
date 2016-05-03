## Changelog
---------

- 0.4.1
-- Updated sshd config to include approved ciphers (RHEL6 STIG 6.2.11)
-- Added the ability to change `ChallengeResponseAuthentication` in sshd config
-- Added the ability to change `UsePAM` in sshd config

- 0.4.0
-- Users may now add auditd rules directly as a series of attributes

- 0.3.11
-- More Auditd fixes

- 0.3.10
-- Fix auditd default parameters which break the build
-- Add documentation for new attributes

- 0.3.9
-- Fully parameterized auditd configuration file
-- No longer calling the auditd cookbook directly from auditd.rb
-- Auditd cookbook is no longer a direct dependency of the STIG cookbook. Should be part of an overall runlist

- 0.3.8
-- Updated STIG and Audit rules to CIS RHEL Stig 1.4.0
-- Added CentOS 6 ruleset 3.2 - "Remove the X Window System"
-- Fixed and added many Serverspec tests
-- Corrected a typo in `check_duplicate_gid.sh` to correct STIG control number
-- Removed CIS wording from audit scripts
-- Enforced permissions on /boot/grub/grub.conf as per STIG 1.5.2
-- Removed grub.conf template
-- Updated mounting of /dev/shm to be idempotent
