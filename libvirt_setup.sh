if [ $EUID -ne 0 ]; then
    echo "This script must run as root!" 
    exit 1
fi

echo "Installing all packages..."
pacman -S qemu-full libvirt virt-manager ovmf dnsmasq

echo "Enabling & starting libvirtd..."
systemctl enable libvirtd
systemctl start libvirtd

echo "Enter the username to get added to the kvm and libvirt groups"
read username

echo "Adding user $username to groups"
usermod -a -G kvm $username
usermod -a -G libvirt $username

echo "Moving old configs..."
mv /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
mv /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.old

echo "Replacing configs..."
cp configs/libvirtd.conf /etc/libvirt/libvirtd.conf
cp configs/qemu.conf /etc/libvirt/qemu.conf

echo "Restarting libvirtd..."
systemctl restart libvirtd