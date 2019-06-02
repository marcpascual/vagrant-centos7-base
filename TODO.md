### image reduce
- https://stackoverflow.com/questions/35727026/how-to-reduce-the-size-of-vagrant-vm-image
- https://stackoverflow.com/questions/11659005/how-to-resize-a-virtualbox-vmdk-file/35620550#35620550
- the size(s) of the vmdk files does not seem to impact the vbox size

```
m@HP MINGW64 ~/VirtualBox VMs/template
$ ll cen* clon*
-rw-r--r-- 1 m 197121 1676935168 Jun  2 21:34 centos-7-1-1.x86_64.vmdk
-rw-r--r-- 1 m 197121 1465712640 Jun  2 21:23 centos-7-1-1.x86_64-resized.vmdk
-rw-r--r-- 1 m 197121 1480589312 Jun  2 21:23 cloned.vdi

m@HP MINGW64 ~/git/vagrant/vagrant-centos7-base-DONOTUSE (master)
$ ll *.box
-rw-r--r-- 1 m 197121 541040278 Jun  2 20:59 package.box
-rw-r--r-- 1 m 197121 541040291 Jun  2 21:31 package2.box
-rw-r--r-- 1 m 197121 541040821 Jun  2 21:38 package3.box
```
