#!/bin/bash

# resize the vmdk before packaging with vagrant
# https://stackoverflow.com/questions/11659005/how-to-resize-a-virtualbox-vmdk-file/35620550#35620550

if [ 1 -eq 0 ]; then
  vboxmanage clonehd "source.vmdk" "cloned.vdi" --format vdi
  vboxmanage modifyhd "cloned.vdi" --compact
  vboxmanage clonehd "cloned.vdi" "resized.vmdk" --format vmdk
  vagrant package
fi
