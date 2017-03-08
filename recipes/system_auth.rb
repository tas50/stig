# Cookbook Name:: stig
# Recipe:: system_auth
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Sysauth and password-auth

require 'pathname'

platform = node['platform']

pass_reuse_limit = node['stig']['system_auth']['pass_reuse_limit']
pamd_dir = '/etc/pam.d'

# We assume that the system-auth and password-auth files are symlinks. I want to
# check the full path that they're symlinked to and use that path in this recipe
# Previously, I was hard-coding the real file at /etc/pam.d/system-auth-ac and
# /etc/pam.d/password-auth-ac but because other installations like Centrify took
# those files and created a file structure that looks like:
#
# lrwxrwxrwx.  1 root root   29 Mar  8 18:59 system-auth -> /etc/pam.d/system-auth-ac.cdc
# -rw-r--r--.  1 root root 1262 Mar  8 18:59 system-auth-ac.cdc
# -rw-------.  1 root root  905 Mar  8 18:59 system-auth-ac.pre_cdc
#
# This recipe would end up blowing away system-auth and creating havoc on the system
# If these happen to not be symlinks, there is a guard that stops this recipe from
# needlessly creating a symlink
system_auth_symlink = "#{pamd_dir}/system-auth"
system_auth_file = File.symlink?(system_auth_symlink) ? Pathname.new(system_auth_symlink).realpath.to_s : system_auth_symlink

password_auth_symlink = "#{pamd_dir}/password-auth"
password_auth_file = File.symlink?(system_auth_symlink) ? Pathname.new(password_auth_symlink).realpath.to_s : password_auth_symlink

bash 'update_pass_reuse_in_pam_sysauth' do
  code <<-EOF
  # Test if the password reuse line is in /etc/pam.d/system-auth
  grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so' #{system_auth_file}

  if [ $? -eq 0 ]; then
    # Line was in the file. Now test whether it has the remember text in it
    grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so\(.*\)remember' #{system_auth_file}
    if [ $? -eq 0 ]; then
      # It already has a remember value. Just need to replace it
      sed -i 's/remember=.*/remember=#{pass_reuse_limit}/' #{system_auth_file}
    else
      # Remember limit is not in the file. Append it to the end
      sed -i '/^password[[:space:]]*sufficient[[:space:]]*pam_unix.so/s/$/ remember=#{pass_reuse_limit}/' #{system_auth_file}
      fi
    else
      # Line was not in the file. Add it to the end
      echo 'password    sufficient    pam_unix.so try_first_pass use_authtok nullok sha512 shadow remember=#{pass_reuse_limit}' >> #{system_auth_file}
      fi
      EOF
  only_if { %w(rhel fedora centos).include? platform }
  not_if "grep -q 'remember=#{pass_reuse_limit}' #{system_auth_file}"
end

bash 'update_pass_reuse_in_pam_password_auth' do
  code <<-EOF
  # Test if the password reuse line is in /etc/pam.d/password-auth
  grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so' #{password_auth_file}

  if [ $? -eq 0 ]; then
    # Line was in the file. Now test whether it has the remember text in it
    grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so\(.*\)remember' #{password_auth_file}
    if [ $? -eq 0 ]; then
      # It already has a remember value. Just need to replace it
      sed -i 's/remember=.*/remember=#{pass_reuse_limit}/' #{password_auth_file}
    else
      # Remember limit is not in the file. Append it to the end
      sed -i '/^password[[:space:]]*sufficient[[:space:]]*pam_unix.so/s/$/ remember=#{pass_reuse_limit}/' #{password_auth_file}
      fi
    else
      # Line was not in the file. Add it to the end
      echo 'password    sufficient    pam_unix.so try_first_pass use_authtok nullok sha512 shadow remember=#{pass_reuse_limit}' >> #{password_auth_file}
      fi
      EOF
  only_if { %w(rhel fedora centos).include? platform }
  not_if "grep -q 'remember=#{pass_reuse_limit}' #{password_auth_file}"
end
#
# file system_auth_symlink do
#   action :delete
#   not_if "test -L #{system_auth_symlink}"
# end
#
# file password_auth_symlink do
#   action :delete
#   not_if "test -L #{password_auth_symlink}"
# end

link system_auth_symlink do
  to system_auth_file
  only_if { File.symlink?(system_auth_symlink) && system_auth_symlink != system_auth_file }
end

link password_auth_symlink do
  to password_auth_file
  only_if { File.symlink?(password_auth_symlink) && password_auth_symlink != password_auth_file }
end

template '/etc/pam.d/common-password' do
  source 'etc_pam.d_common-password.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(
    pass_reuse_limit: pass_reuse_limit
  )
  only_if { %w(debian ubuntu).include? platform }
end
