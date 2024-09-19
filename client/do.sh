echo 1 > /proc/sys/net/ipv4/ip_forward
echo $(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1):12346
echo $(ip -6 addr show eth0 | grep -oE '([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}' | head -n 1):12346
sysctl -p
nc -u -l -p 12346