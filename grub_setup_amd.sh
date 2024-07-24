if [ $EUID -ne 0 ]; then
    echo "This script must run as root!" 
    exit 1
fi

sleep 1

echo "Adding 'amd_iommu=on iommu=pt video=efifb:off' to GRUB config..."
GRUB=`cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev`
GRUB+=" amd_iommu=on iommu=pt video=efifb:off\""
sed -i -e "s|^GRUB_CMDLINE_LINUX_DEFAULT.*|${GRUB}|" /etc/default/grub
sleep 1
clear

echo "Making GRUB config..."
grub-mkconfig -o /boot/grub/grub.cfg
sleep 5
