#!/sbin/sh
#
# extract web interface
#
busybox=/tmp/busybox

$busybox tar -zxf /tmp/htdocs.tar.gz -C /sdcard/
$busybox chmod -R 0777 /sdcard/htdocs

rm /data/local/kali-armhf/etc/dnsmasq.conf
cd /data/local/kali-armhf/etc/
ln -s /sdcard/htdocs/files/dnsmasq.conf dnsmasq.conf

