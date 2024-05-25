if [ $EUID -ne 0 ]
	then
		echo "This program must run as root to function." 
		exit 1
fi
sleep 1s

echo "Installing all packages..."
pacman -S qemu-full libvirt virt-manager ovmf dnsmasq
sleep 1s
clear

echo "Enabling & starting libvirtd..."
systemctl enable libvirtd
systemctl start libvirtd
sleep 1s
clear

echo "Enter a username to add to kvm and libvirt groups"
read USERNAME
clear
gpasswd -M $USERNAME kvm
gpasswd -M $USERNAME libvirt
sleep 1s
clear

echo "Moving old configs..."
mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old
sleep 1s
clear

echo "Replacing configs..."
mv libvirtd_custom.conf /etc/libvirt/libvirt.conf
mv qemu_custom.conf /etc/libvirt/qemu.conf
sleep 1s
clear

echo "Restarting libvirtd..."
systemctl restart libvirtd
sleep 5s
exit