# Cookbook Name:: stig
# Recipe:: system_auth
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Sysauth and password-auth

platform = node['platform']

pass_reuse_limit = node['stig']['system_auth']['pass_reuse_limit']
system_auth_file = '/etc/pam.d/system-auth-ac'
password_auth_file = '/etc/pam.d/password-auth-ac'

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

file '/etc/pam.d/system-auth' do
  action :delete
  not_if 'test -L /etc/pam.d/system-auth'
end

file '/etc/pam.d/password-auth' do
  action :delete
  not_if 'test -L /etc/pam.d/password-auth'
end

link '/etc/pam.d/system-auth' do
  to system_auth_file
end

link '/etc/pam.d/password-auth' do
  to password_auth_file
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
