
    
## for virtual box
#echo "sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.56.101 metric 3"
#sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.56.101 metric 3


## for KVM
#sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.122.120 metric 3
sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.100.132 metric 3
route

#echo "Mount h driver to /media/h"
#sudo mount -t cifs //vhub.sh.cn.ao.ericsson.se/home/elluffn /media/h -o user=elluffn,domain=ERICSSON,uid=106559,gid=64000,nodfs
#sudo mount -t cifs //vhub.rnd.ki.sw.ericsson.se/home/elluffn /media/elluffn/ -o user=elluffn,domain=ericsson,rw,nodfs,uid=1000,gid=1000

#echo "Start VirtualBox"
#rm nohup.out
#nohup VirtualBox&


# sudo mount -t cifs //vhub.sh.cn.ao.ericsson.se/proj/upg /workspace/upg -o username=elluffn,uid=1000,gid=1000,iocharset=utf8,sec=ntlm
