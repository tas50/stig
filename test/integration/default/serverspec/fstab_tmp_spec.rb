require 'spec_helper'


if ['debian','ubuntu'].include?(host_inventory['platform'])
  # Ubuntu 2.14
  describe command('grep /run/shm /etc/fstab | grep nodev') do
    its(:stdout) { should match /nodev/ }
  end
  describe command("mount | grep /run/shm | grep nodev") do
    its(:stdout) { should match /nodev/ }
  end

  # Ubuntu 2.15
  describe command('grep /run/shm /etc/fstab | grep nosuid') do
    its(:stdout) { should match /nosuid/ }
  end
  describe command("mount | grep /run/shm | grep nosuid") do
    its(:stdout) { should match /nosuid/ }
  end

  # Ubuntu 2.16
  describe command('grep /run/shm /etc/fstab | grep noexec') do
    its(:stdout) { should match /noexec/ }
  end
  describe command("mount | grep /run/shm | grep noexec") do
    its(:stdout) { should match /noexec/ }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  describe command('grep /dev/shm /etc/fstab | grep nodev') do
    its(:stdout) { should match /nodev/ }
  end
  describe command("mount | grep /dev/shm | grep nodev") do
    its(:stdout) { should match /nodev/ }
  end

  describe command('grep /dev/shm /etc/fstab | grep nosuid') do
    its(:stdout) { should match /nosuid/ }
  end
  describe command("mount | grep /dev/shm | grep nosuid") do
    its(:stdout) { should match /nosuid/ }
  end

  describe command('grep /dev/shm /etc/fstab | grep noexec') do
    its(:stdout) { should match /noexec/ }
  end
  describe command("mount | grep /dev/shm | grep noexec") do
    its(:stdout) { should match /noexec/ }
  end

  describe file('/dev/shm') do
    it { should be_mounted }
  end

describe command('mount | grep /var/tmp') do
  its(:stdout) { should contain('/var/tmp') }
end

  describe file('mount | grep /var/tmp') do
    it { should be_mounted }
    it do
      should be_mounted.only_with(
        :device  => '/tmp',
        :type    => 'none',
        :options => {
          :rw   => true,
          :bind => true
        }
      )
    end
  end

end
