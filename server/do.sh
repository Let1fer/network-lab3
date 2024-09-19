echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
ip4=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)
if [[ "$ip4" == "172.21.0.3" ]]; then 
    ip6="2001:db8::3"
else 
    ip6="2001:db8::2"
fi
iptables -t nat -A PREROUTING -d 172.21.0.4 -p udp --dport 12345 -j DNAT --to $ip4
ip6tables -t nat -A PREROUTING -d 2001:db8::4/64 -p udp --dport 12345 -j DNAT --to $ip6
# iptables -t nat -A PREROUTING -d 172.21.0.4 -p tcp --dport 12345 -j DNAT --to $(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1):12345
# iptables -t filter -A OUTPUT -s 172.21.0.3 -p tcp -j DROP
# iptables -t nat -A OUTPUT -p tcp -j DNAT --to 172.21.0.4:12346
# tcpdump port 12345
nc -u -l -p 12345