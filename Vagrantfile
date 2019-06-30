# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = "template"
VERSION = "0.0.5"

Vagrant.configure("2") do |config|

  # toggle virtualbox guest additions installation for faster testing
  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = true

  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
    vb.name = HOSTNAME
    # dont use a linked clone for template
    # vb.linked_clone = true
    vb.memory = "2048"
    vb.cpus = 2
    # change nic type of eth0 to virtio (defaults to e1000). however this does not
    # get rid of that annoying warning message during vagrant up
    # vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    # set default nic type for this vm
    # https://www.vagrantup.com/docs/virtualbox/configuration.html
    vb.default_nic_type = "virtio"
  end

  # change the hostname
  config.vm.provision "shell", :args => HOSTNAME,  inline: <<-SHELL
    hostnamectl set-hostname $1
    reboot
  SHELL

  # make sure that reload plugin is installed first
  # https://stackoverflow.com/questions/34910988/is-it-possible-to-restart-a-machine-when-provisioning-a-machine-using-vagrant-an
  # vagrant plugin install vagrant-reload
  config.vm.provision :reload

  # install EPEL and all other tools we need
  config.vm.provision "shell", inline: <<-SHELL
   rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   yum -y install git wget net-tools telnet vim-enhanced java-1.8.0-openjdk.x86_64 \
		jq psmisc pstree unzip docker docker-compose
  SHELL

  config.vm.provision :reload

  # do some cleanup to reduce the box size
  # https://stackoverflow.com/questions/35727026/how-to-reduce-the-size-of-vagrant-vm-image
  # https://stackoverflow.com/questions/11659005/how-to-resize-a-virtualbox-vmdk-file/35620550#35620550
	#
	# unable to ssh to the machine after packaging due to different keys
  # https://blog.pythian.com/vagrant-re-packaging-ssh/
  config.vm.provision "shell", inline: <<-SHELL
    yum clean all
    rm -rf /tmp/*
    rm -rf /var/cache/yum
    cat /dev/zero > z; sync; sleep 3; sync; rm -f z
		echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant' > /home/vagrant/.ssh/authorized_keys
  SHELL

end
