#!/sbin/sh
#
# extract web interface
#
busybox=/tmp/busybox

$busybox tar -zxf /tmp/htdocs.tar.gz -C /sdcard/
$busybox chmod -R 0777 /sdcard/htdocs

# Add mana configuration to webserver

rm /data/local/kali-armhf/root/mana/run-mana/conf/hostapd-karma.conf
rm /data/local/kali-armhf/root/mana/run-mana/conf/dhcpd.conf
rm /data/local/kali-armhf/root/mana/run-mana/conf/dnsspoof.conf


cd /data/local/kali-armhf/root/mana/run-mana/conf/
$busybox ln -s /sdcard/htdocs/files/hostapd-karma.conf hostapd-karma.conf
$busybox ln -s /sdcard/htdocs/files/dhcpd.conf dhcpd.conf
$busybox ln -s /sdcard/htdocs/files/dnsspoof.conf dnsspoof.conf

rm /data/local/kali-armhf/etc/dnsmasq.conf
cd /data/local/kali-armhf/etc/
$busybox ln -s /sdcard/htdocs/files/dnsmasq.conf dnsmasq.conf


