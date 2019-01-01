# CentOS 7 base Vagrant box for general-purpose testing

## configuration:
- disabled ipv6
- 2 nics. eth0 for NAT (internet access), eth1 for host-only (app testing)
- virtualbox guest additions installed
- based on centos/7 from vagrantcloud.com
- EPEL enabled
- openjdk 1.8.0 installed

## steps:
- run *scripts/init.sh* to install the required vagrant plugins
- run *vagrant up*
- run *vagrant halt*
- cat *scripts/vboxmanage-resize.sh*, follow the sample commands to reduce the vmdk size of the vm
- run *vagrant package*

upload to vagrant cloud with:
```
vagrant cloud publish -f --release --description "base CentOS 7 + custom config and guest additions" --short-description "base CentOS 7 for general-purpose testing" --version-description "first release" marcpascual/base-centos7 0.0.1 virtualbox package.box
```
