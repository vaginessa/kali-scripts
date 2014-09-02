kill -9 `ps | grep lighttpd | grep -v grep | awk '{print $2}'`  2>/dev/null
lighttpd -f /system/etc/lighttpd/lighttpd.conf
