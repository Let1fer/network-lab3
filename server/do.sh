echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
echo $(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1):12345
echo $(ip -6 addr show eth0 | grep -oE '([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}' | head -n 1):12345
iptables -t nat -A PREROUTING -d 172.21.0.4 -p udp --dport 12345 -j DNAT --to $(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)
ip6tables -t nat -A PREROUTING -d 2001:db8::4 -p udp --dport 12345 -j DNAT --to $(ip -6 addr show eth0 | grep -oE '([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}' | head -n 1)
# iptables -t nat -A PREROUTING -d 172.21.0.4 -p tcp --dport 12345 -j DNAT --to $(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1):12345
# iptables -t filter -A OUTPUT -s 172.21.0.3 -p tcp -j DROP
# iptables -t nat -A OUTPUT -p tcp -j DNAT --to 172.21.0.4:12346
# tcpdump port 12345
nc -u -l -p 12345