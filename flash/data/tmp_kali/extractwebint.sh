#!/sbin/sh
#
# extract web interface
#
busybox=/tmp/busybox

$busybox tar -zxf /tmp/htdocs.tar.gz -C /sdcard/
$busybox chmod -R 0777 /sdcard/htdocs

rm -rf /data/local/kali-armhf/etc/dnsmasq.conf
cd /data/local/kali-armhf/etc/
ln -s /sdcard/htdocs/files/dnsmasq.conf dnsmasq.conf

rm -rf /data/local/kali-armhf/etc/dhcp/dhcpd.conf
mkdir -p /data/local/kali-armhf/etc/dhcp/
cd /data/local/kali-armhf/etc/dhcp/
ln -s /sdcard/htdocs/files/dhcpd.conf dhcpd.conf
