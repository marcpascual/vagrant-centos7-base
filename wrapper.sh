#!/bin/bash

set -euo pipefail

VERSION="`grep ^VERSION Vagrantfile | awk '{print $NF}'`"

# publish to vagrant cloud
PUBLISH=0

# clean up build artifacts
CLEANUP=0

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

titlewrap "install required vagrant plugins"
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-vbguest

titlewrap "download the centos/7 base image"
vagrant box add centos/7 --provider virtualbox || true

titlewrap "bring up our machine"
vagrant up

titlewrap "halt our machine"
vagrant halt

titlewrap "generate vagrant package"
vagrant package --base template --output package.box

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

