kill -9 `ps | grep lighttpd | grep -v grep | awk '{print $2}'`
lighttpd -f /system/etc/lighttpd/lighttpd.conf
