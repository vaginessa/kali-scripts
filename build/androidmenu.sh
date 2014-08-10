#!/bin/bash

# Modified to include menu system

# Kernel Development requires Kali 64bit host

f_check_version(){
		
		# Allower user input of version number/folder creation to make set up easier
		clear
		echo ""
        read -p "Create working folder. Enter version number: " VERSION
        basedir=`pwd`/android-$VERSION

        if [ -d "${basedir}" ]; then
        		echo ""
                echo "Working folder / version already exsists, use a different version number?"
                echo ""
                read -p "Do you wish to continue with same version number? (y/n)" CONT
                if [ "$CONT" == "y" ]; then
                	f_interface
                else
                	exit 1
                fi
        else
                echo "Working folder / version does not exist, using version number and creating work folder ${basedir}"
                f_interface
fi
}

f_interface(){
clear
echo -e "		         \e[1mKALI LINUX BUILDER FOR ANDROID DEVICES\e[0m"
echo ""
echo "	   WORK PATH: ${basedir}"
echo ""
echo -e "\e[31m	----------------------------   NEXUS 10    -----------MANTA ------------\e[0m"
echo "	[1] Build for Nexus 10 Kernel with wireless USB support (Android 4.4+)"
echo ""
echo -e "\e[31m	----------------------------  NEXUS 7 (2012) ----GROUPER/NAKASI---------\e[0m"
echo "	[2] Build for Nexus 7 (2012) with wireless USB support (Android 4.4+)"
echo ""
echo -e "\e[31m	----------------------------  NEXUS 7 (2013) --------DEB/FLO-----------\e[0m"
echo "	[3] Build for Nexus 7 (2013) with wireless USB support (Android 4.4+)"
echo ""
echo ""
echo "	[88] Rootfs only - For any rooted and unlocked device but without kernel support"
echo "	[99] Unmount and Clean Work Folders (file dir removal currently disabled)"
echo "	[q] Exit"
echo ""
echo ""
# wait for character input

read -p "Choice: " menuchoice

case $menuchoice in

1) clear; f_manta ;;
2) clear; f_grouper ;;
3) clear; f_deb ;;
88) clear; f_rootfs ; f_flashzip; f_zip_save ;;
99) f_cleanup ;;
q) clear; exit 1 ;;
*) echo "Incorrect choice..." ;
esac
}

f_manta(){
echo -e "\e[31m	------------------------- NEXUS 10 -----------------------\e[0m"
echo ""
echo "	[1] Build All - Kali rootfs and Kernel (Android 4.4+)"
echo "	[2] Build Kernel Only"
echo "	[0] Exit to Main Menu"
echo ""
echo ""
# wait for character input

read -p "Choice: " manta_menuchoice

case $manta_menuchoice in

1) clear; f_rootfs ; f_flashzip ; f_nexus10_kernel ; f_zip_save ; f_zip_kernel_save ;;
2) clear; f_nexus10_kernel ; f_zip_kernel_save ;;
0) clear; f_interface ;;
*) echo "Incorrect choice..." ;
esac

}

f_grouper(){
echo -e "\e[31m	------------------------- NEXUS 7 (2012) -----------------------\e[0m"
echo ""
echo "	[1] Build All - Kali rootfs and Kernel (Android 4.4+)"
echo "	[2] Build Kernel Only"
echo "	[0] Exit to Main Menu"
echo ""
echo ""
# wait for character input

read -p "Choice: " grouper_menuchoice

case $grouper_menuchoice in

1) clear; f_rootfs ; f_flashzip ; f_nexus7_grouper_kernel ; f_zip_save ; f_zip_kernel_save ;;
2) clear; f_nexus7_grouper_kernel ; f_zip_kernel_save ;;
0) clear; f_interface ;;
*) echo "Incorrect choice... " ;
esac

}

f_deb(){
echo -e "\e[31m	------------------------- NEXUS 7 (2013) -----------------------\e[0m"
echo ""
echo "	[1] Build All - Kali rootfs and Kernel (Android 4.4+)"
echo "	[2] Build Kernel Only"
echo "	[0] Exit to Main Menu"
echo ""
echo ""
# wait for character input

read -p "Choice: " deb_menuchoice

case $deb_menuchoice in

1) clear; f_rootfs ; f_flashzip ; f_nexus7_deb_kernel ; f_zip_save ; f_zip_kernel_save ;;
2) clear; f_nexus7_deb_kernel ; f_zip_kernel_save ;;
0) clear; f_interface ;;
*) echo "Incorrect choice... " ;
esac
}

f_check_crosscompile(){
# Make sure that the cross compiler can be found in the path before we do
# anything else, that way the builds don't fail half way through.
export CROSS_COMPILE=arm-linux-gnueabihf-
if [ $(compgen -c $CROSS_COMPILE | wc -l) -eq 0 ] ; then
        echo "Missing cross compiler for Android root filesystem." 
        echo "Set up PATH according to the README"
        echo ""
        read -p "Enter export path (probable path): " -e -i "export PATH=${PATH}:/root/arm-stuff/gcc-arm-linux-gnueabihf-4.7/bin" EXPORT_PATH
        $EXPORT_PATH
        unset CROSS_COMPILE
else
        echo "Found cross compiler - will continue"
        unset CROSS_COMPILE
fi
}

f_rootfs(){

f_check_crosscompile

# Package installations for various sections.

arm="abootimg cgpt fake-hwclock ntpdate vboot-utils vboot-kernel-utils uboot-mkimage"
base="kali-menu kali-defaults initramfs-tools usbutils openjdk-7-jre"
desktop="kali-defaults kali-root-login desktop-base xfce4 xfce4-places-plugin xfce4-goodies"
tools="nmap metasploit tcpdump tshark wireshark burpsuite armitage sqlmap recon-ng wipe socat ettercap-text-only beef-xss "
wireless="wifite iw aircrack-ng gpsd kismet kismet-plugins giskismet hostapd dnsmasq wvdial"
services="autossh openssh-server lighttpd tightvncserver postgresql openvpn"
extras="wpasupplicant zip macchanger dbd florence"

export packages="${arm} ${base} ${desktop} ${tools} ${wireless} ${services} ${extras}"
export architecture="armhf"

mkdir -p ${basedir}
cd ${basedir}

# create the rootfs - not much to modify here, except maybe the hostname.
debootstrap --foreign --arch $architecture kali kali-$architecture http://http.kali.org/kali

cp /usr/bin/qemu-arm-static kali-$architecture/usr/bin/

# SECOND STAGE CHROOT

LANG=C chroot kali-$architecture /debootstrap/debootstrap --second-stage

cat << EOF > kali-$architecture/etc/apt/sources.list
deb http://http.kali.org/kali kali main contrib non-free
deb http://security.kali.org/kali-security kali/updates main contrib non-free
EOF

#define hostname

echo "kali" > kali-$architecture/etc/hostname

# fix for TUN symbolic link to enable programs like openvpn
# set terminal length to 80 because root destroy terminal length
# add fd to enable stdin/stdout/stderr
cat << EOF > kali-$architecture/root/.bash_profile
export TERM=xterm-256color
stty columns 80
/usr/bin/firstrun # we can remove this with sed at the end of the firstrun script
cd /root/
if [ ! -d "/dev/net/" ]; then
  mkdir -p /dev/net
  ln -sf /dev/tun /dev/net/tun
fi

if [ ! -d "/dev/fd/" ]; then
  ln -sf /proc/self/fd /dev/fd
  ln -sf /dev/fd/0 /dev/stdin
  ln -sf /dev/fd/1 /dev/stdout
  ln -sf /dev/fd/2 /dev/stderr
fi
EOF

cat << EOF > kali-$architecture/etc/hosts
127.0.0.1       localhost
::1             localhost ip6-localhost ip6-loopback
EOF

cat << EOF > kali-$architecture/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

EOF

cat << EOF > kali-$architecture/etc/resolv.conf
#opendns
nameserver 208.67.222.222
nameserver 208.67.220.220
#google dns
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# THIRD STAGE CHROOT

export MALLOC_CHECK_=0 # workaround for LP: #520465
export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

mount -t proc proc kali-$architecture/proc
mount -o bind /dev/ kali-$architecture/dev/
mount -o bind /dev/pts kali-$architecture/dev/pts

cat << EOF > kali-$architecture/debconf.set
console-common console-data/keymap/policy select Select keymap from full list
console-common console-data/keymap/full select en-latin1-nodeadkeys
EOF

cat << EOF > kali-$architecture/third-stage
#!/bin/bash
dpkg-divert --add --local --divert /usr/sbin/invoke-rc.d.chroot --rename /usr/sbin/invoke-rc.d
cp /bin/true /usr/sbin/invoke-rc.d
echo -e "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

apt-get update
apt-get install locales-all

debconf-set-selections /debconf.set
rm -f /debconf.set
apt-get update
apt-get -y install git-core binutils ca-certificates initramfs-tools uboot-mkimage
apt-get -y install locales console-common less nano git
echo "root:toor" | chpasswd
sed -i -e 's/KERNEL\!=\"eth\*|/KERNEL\!=\"/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
apt-get --yes --force-yes install $packages

rm -f /usr/sbin/policy-rc.d
rm -f /usr/sbin/invoke-rc.d
dpkg-divert --remove --rename /usr/sbin/invoke-rc.d

rm -f /third-stage
EOF

chmod +x kali-$architecture/third-stage
LANG=C chroot kali-$architecture /third-stage

# Modify kismet configuration to work with gpsd and socat
sed -i 's/\# logprefix=\/some\/path\/to\/logs/logprefix=\/captures\/kismet/g' kali-$architecture/etc/kismet/kismet.conf
sed -i 's/# ncsource=wlan0/ncsource=wlan1/g' kali-$architecture/etc/kismet/kismet.conf
sed -i 's/gpshost=localhost:2947/gpshost=127.0.0.1:2947/g' kali-$architecture/etc/kismet/kismet.conf

# Modify Wifite log saving folder
sed -i 's/hs/\/captures/g' kali-$architecture/etc/kismet/kismet.conf

# Kali Menu (bash script) to quickly launch common Android Programs
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/menu/kalimenu -O kali-$architecture/usr/bin/kalimenu
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/menu/firstrun -O kali-$architecture/usr/bin/firstrun
sleep 5
LANG=C chroot kali-$architecture chmod 755 /usr/bin/kalimenu
LANG=C chroot kali-$architecture chmod 755 /usr/bin/firstrun

# Install nodeJS
#wget http://nodejs.org/dist/node-latest.tar.gz -O kali-$architecture/tmp/node-latest.tar.gz
#tar xvf node-latest.tar.gz -C kali-$architecture/tmp/
#LANG=C chroot kali-$architecture "cd tmp && ./configure --without-snapshot --dest-cpu=arm --dest-os=linux" && make && make install

# Sets the default for hostapd.conf but not really needed as evilap will create it's own now
#sed -i 's#^DAEMON_CONF=.*#DAEMON_CONF=/etc/hostapd/hostapd.conf#' kali-$architecture/etc/init.d/hostapd

# DNSMASQ Configuration options for optional access point
cat <<EOF > kali-$architecture/etc/dnsmasq.conf
log-facility=/var/log/dnsmasq.log
#address=/#/10.0.0.1
#address=/google.com/10.0.0.1
interface=wlan1
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
#no-resolv
log-queries
EOF

# Add missing folders to chroot needed
cap=kali-$architecture/captures
mkdir -p kali-$architecture/root/.ssh/
mkdir -p kali-$architecture/sdcard kali-$architecture/system
mkdir -p $cap/evilap $cap/ettercap $cap/kismet/db $cap/nmap $cap/sslstrip $cap/tshark $cap/wifite $cap/tcpdump 

# Add postgresql user to inet so it can access network
echo "inet:x:3004:postgres,root" >> kali-$architecture/etc/group

# CLEANUP STAGE

cat << EOF > kali-$architecture/cleanup
#!/bin/bash
rm -rf /root/.bash_history
apt-get update
apt-get clean
rm -f /0
rm -f /hs_err*
rm -f cleanup
rm -f /usr/bin/qemu*
EOF

chmod +x kali-$architecture/cleanup
LANG=C chroot kali-$architecture /cleanup

umount kali-$architecture/proc/sys/fs/binfmt_misc
umount kali-$architecture/dev/pts
umount kali-$architecture/dev/
umount kali-$architecture/proc

sleep 5
}

f_flashzip(){
#####################################################
#  Create flashable Android FS.  Git repository holds necessary
#  folders/scripts/files.
#  Flashable zip will need follow structure:
#
#  /busybox/busybox - for mounting data folders
#  /data/app/terminal.apk - download terminal to ensure access to chroot
#  /data/local/kalifs.tar.bz2 - The filesystem
#  /data/local/tmp_kali - shell scripts to unzip filesystem/boot chroot
#  /kernel/zImage - kernel
#  /META-INF/com/google/android/updater-binary - Binary file for edify script
#  /META-INF/com/google/android/updater-script - Edify script to install Kali 
#####################################################

# Create base flashable zip
git clone https://github.com/binkybear/flash.git ${basedir}/flash 
mkdir -p ${basedir}/flash/data/local/
mkdir -p ${basedir}/flash/system/lib/modules

# Add Android applications that are useful to our chroot enviornment
# Required: Terminal application is required
wget -P ${basedir}/flash/data/app/ http://jackpal.github.com/Android-Terminal-Emulator/downloads/Term.apk
# Suggested: BlueNMEA to enable GPS logging in Kismet
wget -P ${basedir}/flash/data/app/ http://max.kellermann.name/download/blue-nmea/BlueNMEA-2.1.apk
# Suggested: Hackers Keyboard for easier typing in the terminal
wget -P ${basedir}/flash/data/app/ https://hackerskeyboard.googlecode.com/files/hackerskeyboard-v1037.apk
# Suggested: Android VNC Viewer
wget -P ${basedir}/flash/data/app/ https://f-droid.org/repo/android.androidVNC_13.apk
}

#####################################################
# Create Nexus 10 Kernel (4.4+)
#####################################################
f_nexus10_kernel(){
f_kernel_build_init

echo "Downloading Kernel"
git clone --depth=1 https://android.googlesource.com/kernel/exynos.git -b android-exynos-manta-3.4-kitkat-mr2 ${basedir}/kernel
cd ${basedir}/kernel

echo "Applying Patches"
# Compat 80211 patch
patch -p1 --no-backup-if-mismatch < ../patches/mac80211.patch

# Fastcharge and y-cable support
# This is working but its a nasty hack from taking the y-cable support in FLO/DEB and putting it into Nexus 10
# Not sure if the battery (smb347.c) needs additional modifications either
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/patches/msm_ycable/fastchg.h -O include/linux/fastchg.h
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/patches/msm_ycable/msm_otg.c -O drivers/usb/otg/msm_otg.c

echo "Downloading/replacing defconfig file"
# Clean kernel folder, enable default config, overwrite .config with one containing enabled wireless and bluetooth devices
make clean
make manta_defconfig
sleep 10
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/defconfigs/nexus10/exynos_kali_defconfig -O .config

# Attach kernel builder to updater-script
echo "#KERNEL_SCRIPT_START" >> ${basedir}/flashkernel/META-INF/com/google/android/updater-script
cat << EOF > ${basedir}/flashkernel/META-INF/com/google/android/updater-script
assert(getprop("ro.product.device") == "manta" || getprop("ro.build.product") == "manta");
ui_print("* Kali Kernel for the Nexus 10 *");
ui_print("Mounting system...");
mount("ext4", "EMMC", "/dev/block/platform/dw_mmc.0/by-name/system", "/system");
ui_print("Deleting old kernel modules...");
delete_recursive("/system/lib/modules");
package_extract_dir("system", "/system");
set_perm_recursive(0, 0, 0644, 0644, "/system/lib/modules");
set_perm_recursive(0, 2000, 0755, 0755, "/system/bin");
ui_print("Installing kernel...");
package_extract_dir("kernel", "/tmp");
set_perm(0, 0, 0777, "/tmp/mkbootimg.sh");
set_perm(0, 0, 0777, "/tmp/mkbootimg");
set_perm(0, 0, 0777, "/tmp/unpackbootimg");
set_perm(0, 0, 0777, "/tmp/busybox");
run_program("/sbin/busybox", "dd", "if=/dev/block/platform/dw_mmc.0/by-name/boot", "of=/tmp/boot.img");
run_program("/tmp/unpackbootimg", "-i", "/tmp/boot.img", "-o", "/tmp/");
run_program("/tmp/mkbootimg.sh");
run_program("/sbin/busybox", "dd", "if=/tmp/newboot.img", "of=/dev/block/platform/dw_mmc.0/by-name/boot");
unmount("/system");
EOF
f_kernel_build
}

#####################################################
# Create Nexus 7 Grouper Kernel (4.4+)
#####################################################
f_nexus7_grouper_kernel(){
f_kernel_build_init

echo "Downloading Kernel"
# Using Kangaroo kernel but feel free to change to Android source
git clone https://github.com/lostdeveloper/kangaroo.git -b kangaroo ${basedir}/kernel
cd ${basedir}/kernel

echo "Applying Patches"
# Applying wireless patches
patch -p1 --no-backup-if-mismatch < ../patches/mac80211.patch

# Patch enables the Android device to act as a keyboard and mouse through usb (send keyboard commands to computer)
wget https://raw.githubusercontent.com/pelya/android-keyboard-gadget/master/kernel-3.1.patch -O ../patches/keyboard_mouse_hid.patch
patch -p1 --no-backup-if-mismatch < ../patches/keyboard_mouse_hid.patch

echo "Downloading/replacing defconfig file"
# Clean kernel folder, enable default config, overwrite .config with one containing enabled wireless and bluetooth devices
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/defconfigs/nexus7-kangaroo/kangaroo_kali_grouper_defconfig -O .config
make clean
make kangaroo_defconfig
sleep 10
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/defconfigs/nexus7-kangaroo/kangaroo_kali_grouper_defconfig -O .config

# Attach kernel builder to updater-script
echo "#KERNEL_SCRIPT_START" >> ${basedir}/flashkernel/META-INF/com/google/android/updater-script
cat << EOF > ${basedir}/flashkernel/META-INF/com/google/android/updater-script
ui_print("MODIFIED FOR KALI LINUX");
set_progress(1.000000);
ui_print("Installing kernel...");
mount("ext4", "EMMC", "/dev/block/platform/sdhci-tegra.3/by-name/APP", "/system");
package_extract_dir("system", "/system");
set_perm_recursive(0, 0, 0644, 0644, "/system/lib/modules");
set_perm_recursive(0, 2000, 0755, 0755, "/system/bin");
set_perm_recursive(0, 0, 0755, 0755, "/system/etc/init.d");
unmount("/system");
package_extract_dir("kernel", "/tmp");
set_perm(0, 0, 0777, "/tmp/mkbootimg.sh");
set_perm(0, 0, 0777, "/tmp/mkbootimg");
set_perm(0, 0, 0777, "/tmp/unpackbootimg");
set_perm(0, 0, 0777, "/tmp/busybox");
set_perm(0, 0, 0777, "/tmp/unpack_add_init.sh");
run_program("/sbin/busybox", "dd", "if=/dev/block/platform/sdhci-tegra.3/by-name/LNX", "of=/tmp/boot.img");
run_program("/tmp/unpackbootimg", "-i", "/tmp/boot.img", "-o", "/tmp/");
run_program("/tmp/mkbootimg.sh");
run_program("/sbin/busybox", "dd", "if=/tmp/newboot.img", "of=/dev/block/mmcblk0p2");
ui_print("");
ui_print("Done, please reboot.");
EOF
f_kernel_build
}

#####################################################
# Create Nexus 7 (2013) FLO/DEB Kernel (4.4+)
#####################################################
f_nexus7_deb_kernel(){
if [ ! -e "/usr/bin/lz4c" ]; then
  echo "Missing lz4c which is needed to build the ROMs.  Downloading and making for system:"
  cd ${basedir}
  wget http://lz4.googlecode.com/files/lz4-r112.tar.gz
  tar -xf lz4-r112.tar.gz
  cd lz4-r112
  make
  make install
  echo "lz4c now installed.  Removing leftovers"
  cd ..
  rm -rf lz4-r112.tar.gz lz4-r112
fi

f_kernel_build_init
clear
echo "  Depending on which ROM, there are two types of kernels"
echo "  a user may use.  Choose which kernel your ROM uses."
echo ""
echo "  [1] Create Stock/AOSP Kernel"
echo "  [2] Create Cyanogenmod/CAF Kernel"
# wait for character input
read -p "Choice: " deb_kernel_menuchoice
case $deb_kernel_menuchoice in

1) clear; f_deb_stock_kernel ;;
2) clear; f_deb_cm_kernel ;;
*) echo "Incorrect choice..." ;
esac
}

f_deb_stock_kernel(){
echo "Downloading Kernel"
git clone https://github.com/flar2/flo.git -b ElementalX kernel

cd ${basedir}/kernel
echo "Applying Patches"
# Compat 80211 patch
patch -p1 --no-backup-if-mismatch < ../patches/mac80211.patch

# Patch enables the Android device to act as a keyboard and mouse through usb (send keyboard commands to computer)
wget https://raw.githubusercontent.com/pelya/android-keyboard-gadget/master/kernel-3.4.patch -O ../patches/keyboard_mouse_hid.patch
patch -p1 --no-backup-if-mismatch < ../patches/keyboard_mouse_hid.patch
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/patches/msm_hid_3_4/android.c -O drivers/usb/gadget/android.c

# Turn on y-cable support
sed -i 's/static bool usbhost_charge_mode = false;/static bool usbhost_charge_mode = true;/g' drivers/usb/otg/msm_otg.c

make clean
make elementalx_defconfig
sleep 10
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/defconfigs/nexus7-flodeb/flo_elx-kali_defconfig -O .config

# Attach kernel builder to updater-script
echo "#KERNEL_SCRIPT_START" >> ${basedir}/flashkernel/META-INF/com/google/android/updater-script
cat << EOF > ${basedir}/flashkernel/META-INF/com/google/android/updater-script
ui_print("MODIFIED FOR KALI LINUX");
set_progress(1.000000);
ui_print("Installing kernel...");
ui_print("Mounting /system");
mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");
package_extract_dir("system", "/system");
set_perm_recursive(0, 0, 0644, 0644, "/system/lib/modules");
set_perm_recursive(0, 2000, 0755, 0755, "/system/bin");
set_perm_recursive(0, 0, 0755, 0755, "/system/etc/init.d");
unmount("/system");
package_extract_dir("kernel", "/tmp");
set_perm(0, 0, 0777, "/tmp/mkbootimg.sh");
set_perm(0, 0, 0777, "/tmp/mkbootimg");
set_perm(0, 0, 0777, "/tmp/unpackbootimg");
set_perm(0, 0, 0777, "/tmp/busybox");
set_perm(0, 0, 0777, "/tmp/unpack_add_init.sh");
run_program("/sbin/busybox", "dd", "if=/dev/block/mmcblk0p14", "of=/tmp/boot.img");
run_program("/tmp/unpackbootimg", "-i", "/tmp/boot.img", "-o", "/tmp/");
run_program("/tmp/mkbootimg.sh");
run_program("/sbin/busybox", "dd", "if=/tmp/newboot.img", "/dev/block/mmcblk0p14");
ui_print("");
ui_print("Done, please reboot.");
EOF

# Start kernel build
f_kernel_build
}

f_deb_cm_kernel(){
echo "Downloading Kernel"
# Using ElementalX kernel but feel free to change to Android source
git clone https://github.com/flar2/flo.git -b Cyanogenmod kernel

cd ${basedir}/kernel

echo "Applying Patches"
# Compat 80211 patch
patch -p1 --no-backup-if-mismatch < ../patches/mac80211.patch

# HID
wget https://raw.githubusercontent.com/pelya/android-keyboard-gadget/master/kernel-3.4.patch -O ../patches/keyboard_mouse_hid.patch
patch -p1 --no-backup-if-mismatch < ../patches/keyboard_mouse_hid.patch
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/patches/msm_hid_3_4/android.c -O drivers/usb/gadget/android.c

# Turn on y-cable support
sed -i 's/static bool usbhost_charge_mode = false;/static bool usbhost_charge_mode = true;/g' drivers/usb/otg/msm_otg.c

make clean
make elementalx_defconfig
sleep 10
wget https://raw.githubusercontent.com/binkybear/kali-scripts/master/defconfigs/nexus7-flodeb/flo_elxcm_kali_defconfig -O .config

# Attach kernel builder to updater-script
echo "#KERNEL_SCRIPT_START" >> ${basedir}/flashkernel/META-INF/com/google/android/updater-script
cat << EOF > ${basedir}/flashkernel/META-INF/com/google/android/updater-script
ui_print("MODIFIED FOR KALI LINUX");
set_progress(1.000000);
ui_print("Installing kernel...");
ui_print("Mounting /system");
mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");
package_extract_dir("system", "/system");
set_perm_recursive(0, 0, 0644, 0644, "/system/lib/modules");
set_perm_recursive(0, 2000, 0755, 0755, "/system/bin");
set_perm_recursive(0, 0, 0755, 0755, "/system/etc/init.d");
unmount("/system");
package_extract_dir("kernel", "/tmp");
set_perm(0, 0, 0777, "/tmp/mkbootimg.sh");
set_perm(0, 0, 0777, "/tmp/mkbootimg");
set_perm(0, 0, 0777, "/tmp/unpackbootimg");
set_perm(0, 0, 0777, "/tmp/busybox");
set_perm(0, 0, 0777, "/tmp/unpack_add_init.sh");
run_program("/sbin/busybox", "dd", "if=/dev/block/mmcblk0p14", "of=/tmp/boot.img");
run_program("/tmp/unpackbootimg", "-i", "/tmp/boot.img", "-o", "/tmp/");
run_program("/tmp/mkbootimg.sh");
run_program("/sbin/busybox", "dd", "if=/tmp/newboot.img", "/dev/block/mmcblk0p14");
ui_print("");
ui_print("Done, please reboot.");
EOF

f_kernel_build
}
#####################################################
# Zip and save 
#####################################################
f_zip_save(){
apt-get install -y zip
clear
# Compress filesystem and add to our flashable zip
cd ${basedir}
tar jcvf kalifs.tar.bz2 kali-$architecture
mv kalifs.tar.bz2 ${basedir}/flash/data/local/

#tar jcvf ${basedir}/flash/data/local/kalifs.tar.bz2 ${basedir}/kali-$architecture
echo "Structure for flashable zip file is complete."
echo "Build a kernel next or select build flashable zip form the main menu."

cd ${basedir}/flash/
zip -r6 update-kali-$VERSION.zip *
mv update-kali-$VERSION.zip ${basedir}
cd ${basedir}
# Generate sha1sum
echo "Generating sha1sum for update-kali$1.zip"
sha1sum update-kali-$VERSION.zip > ${basedir}/update-kali-$VERSION.sha1sum
echo "Flashable Kali zip now located at ${basedir}/update-kali-$VERSION.zip"
echo "Transfer file to device and flash in recovery"
sleep 5
}

f_zip_kernel_save(){
apt-get install -y zip
clear
cd ${basedir}/flashkernel/
zip -r6 kernel-kali-$VERSION.zip *
mv kernel-kali-$VERSION.zip ${basedir}
cd ${basedir}
# Generate sha1sum
echo "Generating sha1sum for kernelkali$1.zip"
sha1sum kernel-kali-$VERSION.zip > ${basedir}/kernel-kali-$VERSION.sha1sum
echo "Kernel can be flashed seperatley if needed using kernel-kali-$VERSION.zip"
echo "Transfer file to device and flash in recovery"
sleep 5
}

f_cleanup(){
# Clean up all the temporary build stuff and remove the directories.
# Comment this out to keep things around if you want to see what may have gone
# wrong.
echo "Unmounting any previous mounted folders"
umount ${basedir}/kali-$architecture/proc/sys/fs/binfmt_misc
umount ${basedir}/kali-$architecture/dev/pts
umount ${basedir}/kali-$architecture/dev/
umount ${basedir}/kali-$architecture/proc

#echo "Removing temporary build files"
#rm -rf ${basedir}/patches ${basedir}/kernel ${basedir}/flash ${basedir}/kali-$architecture ${basedir}/flashkernel
}

##############################################################
# Setup of the Kernel folder can be resued on multiple kernels
##############################################################
f_kernel_build_init(){
clear
# FOLDER CHECKING
#
#if [ -d "${basedir}/kernel" ]; then
#  read -p "Kernel folder already exsists, would you like to startover? (y/n)" kernelanswer
#
#fi

#if [ -d "${basedir}/flashkernel" ]; then
#  read -p "Kernel folder already exsists, would you like to rebuild? (y/n)" flashanswer
#fi

#if [ -d "${basedir}/toolchain" ]; then
#  read -p "Toolchain folder already exsists, would you like to redownload? (y/n)" toolchain answer
#fi

# Create seperate kernel flashable zip in case the kernel just needs to be flashed again
echo "Creating kernel directory structure"
git clone https://github.com/binkybear/flash.git ${basedir}/flashkernel
mkdir -p ${basedir}/flashkernel/system/lib/modules
rm -rf ${basedir}/flashkernel/data
rm -rf ${basedir}/flashkernel/META-INF/com/google/android/updater-script

echo "Downloading Android Toolchian"
# Get android toolchain to compile kernel
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 ${basedir}/toolchain

echo "Setting export paths"
# Set path for Kernel building
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=${basedir}/toolchain/bin/arm-eabi-

# All kernels will have mac80211.patch
echo "Downloading Patches"
mkdir -p patches
wget http://patches.aircrack-ng.org/mac80211.compat08082009.wl_frag+ack_v1.patch -O patches/mac80211.patch
# Additional patches are configured per device
}

##############################################################
# Kernel build so we don't repeat for every different kernel
##############################################################
f_kernel_build(){
echo "Building Kernel"
make -j $(grep -c processor /proc/cpuinfo)
echo "Building modules"
mkdir -p modules
make modules_install INSTALL_MOD_PATH=${basedir}/kernel/modules
echo "Copying Kernel and modules to flashable kernel folder"
find modules -name "*.ko" -exec cp -t ../flashkernel/system/lib/modules {} +

# If this is not just a kernel build by itself it will copy modules and kernel to main flash (rootfs+kernel)
if [ -d "${basedir}/flash/" ]; then
  echo "Detected exsisting /flash folder, copying kernel and modules"
  cp ${basedir}/kernel/arch/arm/boot/zImage ${basedir}/flash/kernel/kernel
  cp ${basedir}/flashkernel/system/lib/modules/* ${basedir}/flash/system/lib/modules
  # Kali rootfs (chroot) looks for modules in a different folder then Android (/system/lib) when using modprobe
  rsync -HPavm --include='*.ko' -f 'hide,! */' ${basedir}/kali-armhf/kernel/modules/lib/modules ${basedir}/kali-armhf/lib/
fi

# Copy kernel to flashable package
cp ${basedir}/kernel/arch/arm/boot/zImage ${basedir}/flashkernel/kernel/kernel
cd ${basedir}

#Adding Kernel build
# 1. Will check if kernel was added to main flashable zip (one with rootfs).  If yes it will skip.
# 2. If it detects #KERNEL_SCRIPT_START it will not add it to flashable zip (rootfs)
# 3. If the updater-script is not found it will assume this is a kernel only build so it will not try to add it

if grep -Fxq "#KERNEL_SCRIPT_START" "${basedir}/flash/META-INF/com/google/android/updater-script"; then
  echo "Kernel already added to main updater-script"
else
  echo "Adding Kernel install to updater-script in main update.zip"
  cat ${basedir}/flashkernel/META-INF/com/google/android/updater-script >> ${basedir}/flash/META-INF/com/google/android/updater-script
fi
}

f_check_version
f_interface