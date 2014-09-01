kill -9 `ps | grep php | grep -v grep | awk '{print $2}'`
/system/xbin/fcgiserver &
