cd /etc/config/wireless 
cd /etc/config/
cat wireless 
/etc/init.d/network restart
/etc/init.d/firewall restart
/etc/init.d/dnsmasq restart
opkg install tailscale
tailscale
tailscale up --advertise-routes=192.168.100.0/24,172.16.0.0/24,10.1.1.0/24 --advertise-exit-node
ll
ash
which bash
cat /etc/config/dropbear 
/etc/init.d/dropbear restart
exit
ls
ls
pwd
pwd
bash
exit
watch
opkg install watch
cd /etc/config/etherwake 
cd /etc/config
ll
cat etherwake
ll
exit
