# Generate package lists
# Example use: ./backup-packages.sh arch.txt aur.txt
ARCH_PACKAGES=$1
AUR_PACKAGES=$2
pacman -Qqe | grep -vx "$(pacman -Qqm)" > $ARCH_PACKAGES
pacman -Qqm > $AUR_PACKAGES
