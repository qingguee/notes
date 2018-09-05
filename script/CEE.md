## connect altlas
10.170.59.36		Atlas VM	Atlas VM IP address
ssh atlasadm@10.170.59.36 
qwqwqwqw


## Update spoffing for each computer node
cp /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini_bk
sed 's/prevent_arp_spoofing=True/prevent_arp_spoofing=False/' /etc/neutron/plugins/ml2/ml2_conf.ini > ml2_conf.ini
cp ml2_conf.ini /etc/neutron/plugins/ml2/
grep prevent_arp_spoofing /etc/neutron/plugins/ml2/ml2_conf.ini
service neutron-openvswitch-agent restart

## Create tenant

source openrc
keystone tenant-create --name UPG2 --description "UPG2"
keystone user-create --name UPG2 --tenant UPG2 --pass upg123
keystone user-role-add --user UPG2 --tenant UPG2 --role admin
keystone tenant-list


## Create flavor

nova flavor-create --is-public false vUPG_SC_minimize 10 8192 100 4

nova flavor-create --is-public false vUPG_PL_minimize 11 8192 12 4

nova flavor-create --is-public false vUPG_SC 12 49152 100 14

nova flavor-create --is-public false vUPG_PL 13 49152 12 14

keystone tenant-list
nova flavor-access-add vUPG_SC_minimize 4356f8ee356441fd83bc1e1897ec67ad
nova flavor-access-add vUPG_PL_minimize 4356f8ee356441fd83bc1e1897ec67ad
nova flavor-access-add vUPG_SC 4356f8ee356441fd83bc1e1897ec67ad
nova flavor-access-add vUPG_PL 4356f8ee356441fd83bc1e1897ec67ad


nova flavor-key vUPG_SC_minimize set hw:watchdog_action=reset
nova flavor-key vUPG_PL_minimize set hw:watchdog_action=reset
nova flavor-key vUPG_SC set hw:watchdog_action=reset
nova flavor-key vUPG_PL set hw:watchdog_action=reset

nova flavor-key vUPG_SC_minimize set hw:cpu_policy=dedicated
nova flavor-key vUPG_PL_minimize set hw:cpu_policy=dedicated
nova flavor-key vUPG_SC set hw:cpu_policy=dedicated
nova flavor-key vUPG_PL set hw:cpu_policy=dedicated

nova flavor-key vUPG_SC_minimize set hw:mem_page_size=1048576
nova flavor-key vUPG_PL_minimize set hw:mem_page_size=1048576
nova flavor-key vUPG_SC set hw:mem_page_size=1048576
nova flavor-key vUPG_PL set hw:mem_page_size=1048576

nova flavor-show vUPG_SC_minimize
nova flavor-show vUPG_PL_minimize
nova flavor-show vUPG_SC
nova flavor-show vUPG_PL


nova flavor-access-list --flavor vUPG_SC_minimize
nova flavor-access-list --flavor vUPG_PL_minimize
nova flavor-access-list --flavor vUPG_SC
nova flavor-access-list --flavor vUPG_PL

## Import vUPG images to CEE via glance

glance image-create --name vUPG_SC_noBFD --disk-format qcow2 --container-format bare --file  /home/atlasadm/SC_no_BFD.cow2 --visibility public --progress
glance image-create --name vUPG_PL --disk-format qcow2 --container-format bare --file /tmp/cluster01/Images/PL_Image.qcow2 --visibility public --progress
glance image-list

glance image-create --name vUPG_SC_lsv1744 --disk-format qcow2 --container-format bare --file /tmp/lsv1744/IMAGE/SC-Image.qcow2 --visibility public --progress

## Available Zone
availability_zone1="SC1_AZ"
availability_zone2="SC2_AZ"
availability_zone3="PL3_AZ"
availability_zone4="PL4_AZ"
host_aggregate_zone1="SC1_HAZ"
host_aggregate_zone2="SC2_HAZ"
host_aggregate_zone3="PL3_HAZ"
host_aggregate_zone4="PL4_HAZ"
nova aggregate-create $host_aggregate_zone1 $availability_zone1
nova aggregate-create $host_aggregate_zone2 $availability_zone2
nova aggregate-create $host_aggregate_zone3 $availability_zone3
nova aggregate-create $host_aggregate_zone4 $availability_zone4

nova host-list

nova aggregate-create MINI_AZ MINI_HAZ
nova aggregate-add-host MINI_AZ compute-0-1.domain.tld
nova aggregate-add-host MINI_AZ compute-0-2.domain.tld
nova aggregate-add-host MINI_AZ compute-0-3.domain.tld
nova aggregate-add-host MINI_AZ compute-0-4.domain.tld
nova aggregate-add-host MINI_AZ compute-0-9.domain.tld

nova aggregate-add-host $host_aggregate_zone1 compute-0-5.domain.tld
nova aggregate-add-host $host_aggregate_zone2 compute-0-6.domain.tld
nova aggregate-add-host $host_aggregate_zone3 compute-0-7.domain.tld
nova aggregate-add-host $host_aggregate_zone4 compute-0-8.domain.tld

nova aggregate-details $host_aggregate_zone1
nova aggregate-details $host_aggregate_zone2
nova aggregate-details $host_aggregate_zone3
nova aggregate-details $host_aggregate_zone4

## Check tenant quota
nova quota-show
nova quota-update --ram 576000 4356f8ee356441fd83bc1e1897ec67ad


## Launch Network stack

heat stack-create -f nw_main.yaml -e nw_env.yaml UPG_NW_mini
heat stack-create -f vnf_main.yaml -e vnf_env.yaml UPG_VNF_mini
heat stack-create -f vnf_main.yaml -e vnf_env.yaml UPG_VNF01

##


cluster config -r -a
