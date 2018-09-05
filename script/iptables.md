

#For vUPG only
sed -i "s/-A INPUT -i -j input_ext/-A INPUT -i eth1 -j input_ext/g" /cluster/home/dveadm/config/iptables-rules.cfg

#For both Native and vUPG
#Restore iptable configure file
cp /opt/dve-repository/dge-common/scripts/iptables-dge-product-rules.cfg /cluster/home/dveadm/config/iptables-dge-product-rules.cfg





#Active firewall on SC-1 and SC-2:
ssh SC-1 "/opt/dve-repository/LOTC-CFG/config/firewall stop"
ssh SC-2 "/opt/dve-repository/LOTC-CFG/config/firewall stop"
ssh SC-1 "/opt/dve-repository/LOTC-CFG/config/firewall start"
ssh SC-2 "/opt/dve-repository/LOTC-CFG/config/firewall start"
ssh SC-1 "iptables -nvL"
ssh SC-2 "iptables -nvL"


#Prepare iptable rule for SC node
sed -i '/6060/d' /home/dveadm/config/iptables-dge-product-rules.cfg
sed -i '/6161/d' /home/dveadm/config/iptables-dge-product-rules.cfg

#Active firewall on PL-3 and PL-4:
ssh PL-3 "/opt/dve-repository/LOTC-CFG/config/firewall start"
ssh PL-4 "/opt/dve-repository/LOTC-CFG/config/firewall start"
ssh PL-3 "iptables -nvL"
ssh PL-4 "iptables -nvL"
