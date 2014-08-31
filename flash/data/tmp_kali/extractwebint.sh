#!/sbin/sh
#
# extract web interface
#
busybox=/tmp/busybox

$busybox tar -zxf /tmp/htdocs.tar.gz -C /sdcard/
$busybox chmod -R 0777 /sdcard/htdocs

# Add mana configuration to webserver

cd /data/local/kali-armhf/opt/mana/run-mana/conf/
rm hostapd-karma.conf
$busybox ln -s /sdcard/htdocs/files/hostapd-karma.conf hostapd-karma.conf
 
# Add hid scripts to webserver

#cd /sdcard/htdocs/files
#mv bad-usb hosts  
#mv keyboard rev-tcp
#mv test2.ps1 rev-met

# Link badandroid host files to webserver 
 
cd /data/local/kali-armhf/opt/badandroid
rm hosts
$busybox ln -s /sdcard/htdocs/files/hosts hosts

$busybox ln -s /sdcard/htdocs/files/rev-tcp rev-tcp
$busybox ln -s /sdcard/htdocs/files/rev-met rev-met