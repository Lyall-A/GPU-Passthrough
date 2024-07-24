if [ $EUID -ne 0 ]; then
    echo "This script must run as root!" 
    exit 1
fi

sleep 1

echo "Installing all packages..."
pacman -S qemu-full libvirt virt-manager ovmf dnsmasq
sleep 1
clear

echo "Enabling & starting libvirtd..."
systemctl enable libvirtd
systemctl start libvirtd
sleep 1
clear

echo "Enter the username to get added to the kvm and libvirt groups"
read username
sleep 1
clear

echo "Adding user $username to groups"
usermod -a -G kvm $username
usermod -a -G libvirt $username
sleep 1
clear

echo "Moving old configs..."
mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old
sleep 1
clear

echo "Replacing configs..."
cp configs/libvirtd.conf /etc/libvirt/libvirtd.conf
cp configs/qemu.conf /etc/libvirt/qemu.conf
sleep 1
clear

echo "Restarting libvirtd..."
systemctl restart libvirtd
sleep 5
