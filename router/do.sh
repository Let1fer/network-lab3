#!/bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
iptables -t mangle -A PREROUTING -d 172.21.0.4 -p udp --dport 12345 -j TEE --gateway 172.21.0.2
iptables -t mangle -A PREROUTING -d 172.21.0.4 -p udp --dport 12345 -j TEE --gateway 172.21.0.3
iptables -t nat -A PREROUTING -s 172.21.0.2 -p udp --dport 12346 -j DNAT --to 172.21.0.5
iptables -t nat -A PREROUTING -s 172.21.0.3 -p udp --dport 12346 -j DNAT --to 172.21.0.5

ip6tables -t mangle -A PREROUTING -d 2001:db8::4 -p udp --dport 12345 -j TEE --gateway 2001:db8::2
ip6tables -t mangle -A PREROUTING -d 2001:db8::4 -p udp --dport 12345 -j TEE --gateway 2001:db8::3
ip6tables -t nat -A PREROUTING -s 2001:db8::2 -p udp --dport 12346 -j DNAT --to 2001:db8::5
ip6tables -t nat -A PREROUTING -s 2001:db8::3 -p udp --dport 12346 -j DNAT --to 2001:db8::5


# iptables -t mangle -A PREROUTING -d 172.21.0.4 -p tcp --dport 12345 -j TEE --gateway 172.21.0.2
# iptables -t nat -A PREROUTING -d 172.21.0.4 -p tcp --dport 12345 -j DNAT --to 172.21.0.6
# iptables -A FORWARD -d 172.21.0.6 -j DROP
# iptables -t mangle -A PREROUTING -d 172.21.0.4 -p tcp --dport 12345 -j TEE --gateway 172.21.0.3
# iptables -t nat -A PREROUTING -s 172.21.0.2 -p tcp --dport 12346 -j DNAT --to 172.21.0.5
# iptables -t nat -A POSTROUTING -s 172.21.0.2 -p tcp --dport 12346 -j SNAT --from 172.21.0.4
# iptables -t nat -A PREROUTING -s 172.21.0.3 -p tcp --dport 12346 -j DNAT --to 172.21.0.5
# iptables -t nat -A POSTROUTING -s 172.21.0.3 -p tcp --dport 12346 -j SNAT --from 172.21.0.4
# iptables -t raw -A PREROUTING -s 172.21.0.3 -p tcp -j DROP
while true; do sleep 1000; done

# nc -u -l -p 12345
# nc -u -p 12346 172.21.0.4 12345
# nc -p 12346 172.21.0.4 12345