#!/bin/sh

echo "[*] Restoring normal USB functionality"
killall dnsmasq
echo 0 > /sys/class/android_usb/android0/enable
echo mtp,adb > /sys/class/android_usb/android0/functions
echo 1 > /sys/class/android_usb/android0/enable

