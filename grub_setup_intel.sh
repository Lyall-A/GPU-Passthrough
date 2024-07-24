if [ $EUID -ne 0 ]; then
    echo "This script must run as root!" 
    exit 1
fi

echo "Adding 'intel_iommu=on iommu=pt' to GRUB config..."
GRUB=`cat /etc/default/grub | grep "GRUB_CMDLINE_LINUX_DEFAULT" | rev | cut -c 2- | rev`
GRUB+=" intel_iommu=on iommu=pt\""
sed -i -e "s|^GRUB_CMDLINE_LINUX_DEFAULT.*|${GRUB}|" /etc/default/grub

echo "Making GRUB config..."
grub-mkconfig -o /boot/grub/grub.cfg