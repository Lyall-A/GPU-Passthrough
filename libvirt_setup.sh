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

echo "Enter the username to get added to the kvm and libvirt groups"
read USERNAME
sleep 1s
clear

echo "Adding user $USERNAME to groups"
usermod -a -G kvm $USERNAME
usermod -a -G libvirt $USERNAME
sleep 1s
clear

echo "Moving old configs..."
mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old
sleep 1s
clear

echo "Replacing configs..."
mv libvirtd.conf /etc/libvirt
mv qemu.conf /etc/libvirt
sleep 1s
clear

echo "Restarting libvirtd..."
systemctl restart libvirtd
sleep 5s
exit