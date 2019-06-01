# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = "template"

Vagrant.configure("2") do |config|

  # toggle virtualbox guest additions installation for faster testing
  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = true

  config.vm.box = "centos/7"

  # with the 2nd nic, port forwarding won't be necessary
  # config.vm.network "forwarded_port", guest: 8443, host: 8443

  # first nic is always NAT
  # second can be anything
  # but set both to virtio
  config.vm.network "private_network",
    ip: "192.168.56.100",
    netmask: "255.255.255.0",
    dhcp_enabled: false,
    nic_type: "virtio",
    forward_mode: "none"

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
  config.vm.provision "shell", inline: <<-SHELL
    hostnamectl set-hostname HOSTNAME
    reboot
  SHELL

  # make sure that reload plugin is installed first
  # https://stackoverflow.com/questions/34910988/is-it-possible-to-restart-a-machine-when-provisioning-a-machine-using-vagrant-an
  # vagrant plugin install vagrant-reload
  config.vm.provision :reload

  # install EPEL and all other tools we need
  config.vm.provision "shell", inline: <<-SHELL
   rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   yum -y install git wget net-tools telnet vim-enhanced java-1.8.0-openjdk.x86_64 jq psmisc pstree
   config.vm.provision :reload
   config.vm.provision "shell", inline: <<-SHELL
   yum clean all
   rm -rf /tmp/*
   rm -rf /var/cache/yum
   cat /dev/zero > z; sync; sleep 3; sync; rm -f z
  SHELL

  # do some cleanup to reduce the box size
  # https://stackoverflow.com/questions/35727026/how-to-reduce-the-size-of-vagrant-vm-image
  # https://stackoverflow.com/questions/11659005/how-to-resize-a-virtualbox-vmdk-file/35620550#35620550
  # config.vm.provision :reload
  # config.vm.provision "shell", inline: <<-SHELL
  #  yum clean all
  #  rm -rf /tmp/*
  #  rm -rf /var/cache/yum
  #  cat /dev/zero > z; sync; sleep 3; sync; rm -f z
  # SHELL

end
