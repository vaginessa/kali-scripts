#!/sbin/sh
#
# extract web interface
#
tar -zxvf /tmp/htdocs.tar.gz -C /sdcard/htdocs
rm /tmp/htdocs.tar.gz

# Add mana configuration to webserver

cd /data/local/kali-armhf/opt/mana/run-mana/conf/
rm hostapd-karma.conf
ln -s /sdcard/htdocs/files/hostapd-karma.conf hostapd-karma.conf
 
# Add hid scripts to webserver

#cd /sdcard/htdocs/files
#mv bad-usb hosts  
#mv keyboard rev-tcp
#mv test2.ps1 rev-met

# Link badandroid host files to webserver 
 
cd /data/local/kali-armhf/opt/badandroid
rm hosts
ln -s /sdcard/htdocs/files/hosts hosts

ln -s /sdcard/htdocs/files/rev-tcp rev-tcp
ln -s /sdcard/htdocs/files/rev-met rev-met
