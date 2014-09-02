kill -9 `ps | grep php | grep -v grep | awk '{print $2}'`  2>/dev/null
/system/xbin/fcgiserver &
