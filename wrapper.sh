#!/bin/bash

set -euo pipefail

VERSION=`grep ^VERSION Vagrantfile | awk '{print $NF}'`

# publish to vagrant cloud
PUBLISH=1

# clean up build artifacts
CLEANUP=1

titlewrap() {
	_LEN=${#1}
	printf "=%.0s" $(seq $_LEN); echo
	echo $1
	printf "=%.0s" $(seq $_LEN); echo
}

if [ -f "package.box" ]; then
	echo "error: existing package.box found, aborting... "
	exit 1
fi

# manually update/delete these plugins if you want to update
titlewrap "install required vagrant plugins"
vagrant plugin list | grep vagrant-reload || vagrant plugin install vagrant-reload
vagrant plugin list | grep vagrant-vbguest || vagrant plugin install vagrant-vbguest

# manually update the box image if you want to
titlewrap "download the centos/7 base image"
vagrant box add centos/7 --provider virtualbox || true

titlewrap "bring up our machine"
vagrant up

titlewrap "halt our machine"
vagrant halt

titlewrap "generate vagrant package"
vagrant package --base template --output package.box

titlewrap "add to local box repository"
vagrant box remove --box-version 0 marcpascual-latest || true
vagbant box add --name marcpascual-latest --provider virtualbox ./package.box

if [ $PUBLISH -eq 1 ]; then
	titlewrap "publish to vagrant cloud"
	vagrant cloud publish -f --release \
		--description "base CentOS 7 + custom config and guest additions" \
  	--short-description "base CentOS 7 for general-purpose testing" \
		--version-description "release $VERSION" \
  	marcpascual/base-centos7 $VERSION virtualbox package.box
fi

if [ $CLEANUP -eq 1 ]; then
	titlewrap "cleanup all build artifacts"
	rm -f package.box
	VBoxManage.exe unregistervm template --delete
fi

