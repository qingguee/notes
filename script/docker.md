

## TCP dump
tcpdump -i eth1 -nn -X -e

ln -s /proc/PIDxxx/ns/net /var/run/netns/ct1

## Ericsson ARM

docker login armdocker.rnd.ericsson.se
# data will be stored in .docker/config.json (old is ~/.dockercfg)
docker tag ubuntu armdocker.rnd.ao.ericsson.se/rdccaiy/ubuntu
docker push armdocker.rnd.ao.ericsson.se/rdccaiy/ubuntu


### atftp
bash-4.3# cat ./etc/sysconfig/SuSEfirewall2.d/services/atftp
## Name: aTFTP Server
## Description: Opens ports for tftp service.

# space separated list of allowed UDP ports
UDP="tftp"
bash-4.3# cat ./usr/lib/systemd/system/atftpd.service
[Unit]
Description=Advanced TFTP Server

[Service]
EnvironmentFile=/etc/sysconfig/atftpd
ExecStart=/usr/sbin/atftpd --user $ATFTPD_USER --group $ATFTPD_GROUP $ATFTPD_OPTIONS $ATFTPD_DIRECTORY
StandardInput=socket

/usr/sbin/atftpd --user tftp --group tftp /tftpboot


## E/// armdocker
Hello,

your namespace is: armdocker.rnd.ericsson.se/proj_elluffn
at Global Docker armdocker.rnd.ericsson.se

Please remember you can browse your new docker namespace after the first upload, because that is just a namespace (a "slice") contained in a global Docker repository

For other info have a look at
https://wiki.lmera.ericsson.se/wiki/ARM/Types/Docker_registry

sudo docker login armdocker.rnd.ericsson.se


## daemon.json 
upg@ecnshlx2033:~$ cat /etc/docker/daemon.json 
{
  "storage-driver": "overlay2",
  "dns": ["147.128.74.79","147.128.68.204","146.11.115.200"],
  "dns-search": ["sh.cn.ao.ericsson.se"]
}

## /etc/default/docker
upg@ecnshlx2033:~$ cat /etc/default/docker 
# Here in Debian, this file is sourced by:
#   - /etc/init.d/docker (sysvinit)
#   - /etc/init/docker (upstart)
#   - systemd's docker.service

# Use of this file for configuring your Docker daemon is discouraged.
#DOCKER_OPTS="-dns 147.128.74.45 ,-dns-search sh.cn.ao.ericsson.se"


# The recommended alternative is "/etc/docker/daemon.json", as described in:
#   https://docs.docker.com/v1.11/engine/reference/commandline/daemon/#daemon-configuration-file

# If that does not suit your needs, try a systemd drop-in file, as described in:
#   https://docs.docker.com/v1.11/engine/admin/systemd/#custom-docker-daemon-options
HTTP_PROXY=http://hubproxy.sh.cn.ao.ericsson.se:8080
http_proxy=$HTTP_PROXY
HTTPS_PROXY=$HTTP_PROXY
https_proxy=$HTTP_PROXY
export HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
upg@ecnshlx2033:~$ 

## docker.service.d/http-proxy.conf
pg@ecnshlx2033:~$ cat /etc/systemd/system/docker.service.d/http-proxy.conf 
[Service]
Environment="HTTP_PROXY=http://hubproxy.sh.cn.ao.ericsson.se:8080/" "HTTPS_PROXY=http://hubproxy.sh.cn.ao.ericsson.se:8080/"


## build server

    sudo docker run --rm -it  -v $PWD/data:/data -v $PWD/m2:/root/.m2/repository -v /media/upg/deliveries/cr/:/proj/upg/deliveries/cr/ bserver

  cd ../CR/sw
  ll |grep root |awk '{print $9}'|xargs  rm -rf {}

## DX tools
sudo docker run --rm -it -v /home/elluffn/dockerfiles/dxtools/data:/data dxt 

sudo docker run --rm -it -v $PWD/data:/data dxt   


## esm build server
    sudo docker run --rm -it  -v $PWD/data:/data -v $PWD/m2:/root/.m2/repository -v /media/upg/deliveries/cr/:/proj/upg/deliveries/cr/ bs-esm