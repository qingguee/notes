
### Ctrix for ELX
Prerequisites for ELX users:

    Install the Citrix Receiver Chrome plugin, installer can be found here: https://chrome.google.com/webstore/detail/citrix-receiver/haiffjcadagjlijoggckpgfnoeiflnem
    Add the following link the first time you start the Citrix Receiver plugin: https://dwp.ra.ericsson.net/

## host

146.11.22.202

### Ericube

The GIC testing ericube environment have been setup.

Here is the information:

 

https://openalm.lmera.ericsson.se/plugins/mediawiki/wiki/adp/index.php?title=Command_line_access_to_K8s_Clusters

https://openalm.lmera.ericsson.se/file/shownotes.php?release_id=38242#/

erikube 0.4.1 cluster kepler (1 LB + 3 masters + 4 workers):   

Dashboard: https://dashboard.kepler.seli.gic.ericsson.se (admin/ericsson)

 

Login on ECN  server,   config you bashalias and export the proper env,  then you can use kubctl to control this cluster.

 

 

exiyshi@ecnshts3020[14:01][/home/exiyshi]$ kubectl get all

NAME                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE

deploy/nfs-provisioner   1         1         1            1           21h

 

NAME                            DESIRED   CURRENT   READY     AGE

rs/nfs-provisioner-5f5bfb988c   1         1         1         21h

 

NAME                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE

deploy/nfs-provisioner   1         1         1            1           21h

 

NAME                            DESIRED   CURRENT   READY     AGE

rs/nfs-provisioner-5f5bfb988c   1         1         1         21h

 

NAME                                  READY     STATUS    RESTARTS   AGE

po/nfs-provisioner-5f5bfb988c-5prlg   1/1       Running   0          21h

 

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                              AGE

svc/kubernetes        ClusterIP   10.96.0.1        <none>        443/TCP                              21h

svc/nfs-provisioner   ClusterIP   10.110.113.231   <none>        2049/TCP,20048/TCP,111/TCP,111/UDP   21h

 

 


## GIT

git clone https://elluffn@gerrit.ericsson.se/a/provisioning/prov-b1


Clone URL
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/prov-b1
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/upg_core
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/user360
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/upg_bl
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/common/prov-cf1
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/common/prov-lsv1
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/common/upg_ci
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/user360_py
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/common/prov-3ppf1
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/udc_cockpit
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/cockpit
git clone ssh://gerritmirror.sh.cn.ao.ericsson.se:29418/provisioning/up_gui

Tips:	
	
› Back up your local changes, delete your local repositories	
› Clone code from above URLs	
› Download hook scipt and set remote URL	
        $ scp -p -P 29418 gerritmirror.sh.cn.ao.ericsson.se:hooks/commit-msg .git/hooks/      	
        $ git remote set-url origin --push ssh://gerrit.ericsson.se:29418/<project>.git	
› Start your work as before	
› "BNET DUCI PIDS CBC 2" is the display name of Jenkins account on global Gerrit server(don't know why), don't remove it from the reviewers list!!!	

##
ed4d600 (HEAD -> upg1_esm_poc, tag: UPG1_ESM_POC_BASE, origin/upg1_esm_poc, 

## manjaro

146.11.23.6

## DNS
- DNS 10.175.250.86

## Install License

scp -r tick@10.175.170.102:~/shunshun/FT/license /cluster/
cd /cluster/license/
./setFinger.sh 32303838-3430-3033-3034-423030303031
cluster reboot -a

/opt/com/bin/cliss

installKeyFile --uri file:////cluster/license/32303838-3430-3033-3034-423030303031_161020_112545.xml --password
cluster reboot -a

## ISO daily
/storage/jenkins/iso/upg/upg_1/upg_1_daily_tmp/latest


## Skype
sip.ericsson.com
chbjmwae201.ericsson.com:443



## Cluster 9

SC-1 ip: 10.170.18.60
OAM_VIP: 10.170.11.189
TRF_VIP: 10.170.11.183
MAP_VIP:10.170.11.184
DIA_VIP: 10.170.11.185
LDAP_VIP: 10.170.11.186
PROV_VIP: 10.170.11.190
MYSQL_VIP:10.170.11.191

## 
vhub.sh.cn.ao.ericsson.se\home\elluffn


##  G8 for K8s
As this G8 machine has been already ordered by UPG team, could you please help us install the linux system on it following below requirements after you can power it on?
 
IP addresses and connections
10.175.170.52
root/root000
eth0 of upg k8s-01 server
connet port 42 of ROUTER-GEP5(10.170.18.1)
10.175.170.53
admin/admin123
iLom for upg k8s-01 server

connet port 43 of ROUTER-GEP5(10.170.18.1)
Gateway: 10.175.170.1
OS: Ubuntu 16.04.3
Because this system will download software from internet, could you also help configure the proxy to make it can browse internet?

## Proxy
www-proxy.lmera.ericsson.se
www-proxy.exu.ericsson.se:8080

## Manjaro
146.11.23.2


## ADP kepler  
How to login k8s lb :
ssh raket@136.225.241.9
 
 
 
other node info:
cat ~/inventory/hosts
[all]
node1 ansible_host=136.225.226.240  hostname=kepler-lb
node2 ansible_host=136.225.226.242  hostname=kepler-master1
node3 ansible_host=136.225.226.243  hostname=kepler-master2
node4 ansible_host=136.225.226.244  hostname=kepler-master3
node5 ansible_host=136.225.226.245  hostname=kepler-node1
node6 ansible_host=136.225.226.246  hostname=kepler-node2
node7 ansible_host=136.225.226.247  hostname=kepler-node3
node8 ansible_host=136.225.226.248  hostname=kepler-node


