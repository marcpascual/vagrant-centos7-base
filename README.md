# CentOS 7 Vagrant config for lab setup

# USED TO BUILD BASE IMAGE ONLY - E.G. FOR UPLOAD TO VAGRANT CLOUD ONLY

## configuration:
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
  TODO: this does not currently work
- run *vagrant package --base template --output package.box*
	this produces a tgz-compressed vagrant image (package.box) ready for publishing
	when exploded, the contents looks like:

```
m@HP MINGW64 ~/git/vagrant/vagrant-centos7-base-DONOTUSE(master)
$ tar -tvf package.box
-rw-rw-rw- 0/0       560495104 2019-06-02 20:58 ./box-disk001.vmdk
-rw-rw-rw- 0/0            6878 2019-06-02 20:56 ./box.ovf
-rw-rw-rw- 0/0             516 2019-06-02 20:58 ./Vagrantfile
```

upload to vagrant cloud with:
```
vagrant cloud publish -f --release --description "base CentOS 7 + custom config and guest additions" \
  --short-description "base CentOS 7 for general-purpose testing" --version-description "first release" \
  marcpascual/base-centos7 0.0.1 virtualbox package.box
```
