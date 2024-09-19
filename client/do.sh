echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
nc -u -l -p 12346