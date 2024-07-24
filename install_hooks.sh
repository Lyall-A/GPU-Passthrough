#!/bin/bash

if [[ -e /etc/libvirt/ && ! -e /etc/libvirt/hooks ]]; then mkdir -p /etc/libvirt/hooks; fi
if [ -e /etc/libvirt/hooks/qemu ]; then mv /etc/libvirt/hooks/qemu /etc/libvirt/hooks/qemu.old; fi
if [ -e /usr/local/bin/vfio-startup ]; then mv /usr/local/bin/vfio-startup /usr/local/bin/vfio-startup.old; fi
if [ -e /usr/local/bin/vfio-teardown ]; then mv /usr/local/bin/vfio-teardown /usr/local/bin/vfio-teardown.old; fi
if [ -e /etc/systemd/system/libvirt-nosleep.service ]; then rm /etc/systemd/system/libvirt-nosleep.service; fi

cp services/libvirt-nosleep.service /etc/systemd/system/libvirt-nosleep.service
cp hooks/vfio-startup /usr/local/bin/vfio-startup
cp hooks/vfio-teardown /usr/local/bin/vfio-teardown
cp hooks/qemu /etc/libvirt/hooks/qemu

chmod +x /usr/local/bin/vfio-startup
chmod +x /usr/local/bin/vfio-teardown
chmod +x /etc/libvirt/hooks/qemu
