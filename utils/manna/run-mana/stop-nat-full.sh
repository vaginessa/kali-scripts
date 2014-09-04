pkill dhcpd
pkill sslstrip
pkill sslsplit
pkill hostapd
pkill python
iptables --policy INPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables --policy OUTPUT ACCEPT
iptables -t nat -F
