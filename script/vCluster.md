# vCluster for testing

This virtual cluster was created based on vUPG 1.8. 
Currently, we use virtual cluster to verify UPG installation with ESM. 


## Prerequisites 
* 300G disk
* 32G free RAM for VMs
* 16 vCPU
* KVM installed

## Copy configuration files
Copy the folder from upg project share folder to your build server. 

    <UPG proj>/upg/team/Tick/testing/vCluster/
    ├── AIT4_image.tar.gz
    ├── ansible_deploy_cluster2.yml
    ├── ansible_install_cluster2.yml
    ├── ansible_setup_ait3_for_cluster2.yml
    ├── ansible_setup_ait4_for_cluster2.yml
    ├── vCluster2_input
    │   ├── cluster.conf
    │   ├── createImage_cluster2.sh
    │   ├── evipcfg.xml
    │   ├── installation.conf
    │   ├── ovf-env.xml
    │   └── upg-defaultScale.config
    └── vmconf
        ├── AIT3.xml
        ├── AIT4.xml
        ├── cluster2_pl_3.xml
        ├── cluster2_pl_4.xml
        ├── cluster2_sc_1.xml
        ├── cluster2_sc_2.xml
        ├── cluster_pl_3.xml
        ├── cluster_pl_4.xml
        ├── cluster_sc_1.xml
        ├── cluster_sc_2.xml
        └── networks
            ├── autostart
            ├── cl2_internal.xml
            ├── cl2_oam.xml
            ├── cluster_internal.xml
            ├── cluster_oam.xml
            └── default.xml

    4 directories, 26 files

* AIT4 can be used. AIT3 is discard, don't use it.
* cluster2 will be used as demo/example.


## Setup networks for cluster2
    virsh net-create vmconf/networks/cl2_internal.xml
    virsh net-create vmconf/cl2_oam.xml

## Setup AIT4 server
    #Untar AIT4 image
    tar xzvf AIT4_image.tar.gz -C /var/lib/libvirt/images/
    #Define AIT4 in KVM
    virsh define vmconf/AIT4.xml
    virsh start AIT4
## Define virtual cluster2
    virsh define vmconf/cluster2_sc_1.xml
    virsh define vmconf/cluster2_sc_2.xml
    virsh define vmconf/cluster2_pl_3.xml
    virsh define vmconf/cluster2_pl_4.xml
## Deploy a CSP via AIT4
* Update ansible_setup_ait4_for_cluster2.yml
```
    ---
    - hosts: ait4
    remote_user: root
    vars:
        aitrepo: /home/aitrepo/cluster2
        tftpboot: /tftpboot
        tftp_sub: cluster2
        local_csp: /workspace/upg/tmp/elluffn/CBA_UPG.tar.gz    
        ovf_env: /workspace/upg/tmp/elluffn/vCluster2_fixed/ovf-env.xml
        cluster_conf: /workspace/upg/tmp/elluffn/vCluster2_fixed/cluster.conf
        evip_conf: /workspace/upg/tmp/elluffn/vCluster2_fixed/evipcfg.xml 
        installation_conf: /workspace/upg/tmp/elluffn/vCluster2_fixed/installation.conf
        defaultScale_conf: /workspace/upg/tmp/elluffn/vCluster2_fixed/upg-defaultScale.config
        coreMW_runtime: coremw_x86_64-4.5.0-277-runtime-sle-cxp9020355
        coreMW_deployment: coremw_x86_64-4.5.0-277-deployment-sle-cxp9017564
        ait_dev: /opt/ait/ait-dev_new/source_ait_dev.bash
        ait_ma: /opt/ait/ait-ag_new/source_ait_ma.bash
        nfs_ip: 192.168.140.80
```

* Execute ansible-playbook
```
    ansible-playbook ansible_deploy_cluster2.yml     
```


