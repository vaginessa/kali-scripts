#!/sbin/sh
#
# extract web interface
#
busybox=/tmp/busybox

$busybox tar -zxf /tmp/htdocs.tar.gz -C /sdcard/
$busybox chmod -R 0777 /sdcard/htdocs

# Add mana configuration to webserver

rm /data/local/kali-armhf/opt/mana/run-mana/conf/hostapd-karma.conf
cd /data/local/kali-armhf/opt/mana/run-mana/conf/
$busybox ln -s /sdcard/htdocs/files/hostapd-karma.conf hostapd-karma.conf



cd /data/local/kali-armhf/opt/badandroid
rm /data/local/kali-armhf/opt/badandroid/hosts
$busybox ln -s /sdcard/htdocs/files/hosts hosts
$busybox ln -s /sdcard/htdocs/files/rev-tcp rev-tcp
$busybox ln -s /sdcard/htdocs/files/rev-met rev-met
$busybox ln -s /sdcard/htdocs/files/rev-met rev-met
