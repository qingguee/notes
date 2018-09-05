
## Detach interface

atlasadm@atlas:~$ neutron port-list|grep VNF_UPG_03_PL3
| 2f1fd9bd-cbd7-4a4d-87c1-8da44bccfbd5 | VNF_UPG_03_PL3_eth3 | fa:16:3e:e2:26:f8 | {"subnet_id": "c57f8e76-956c-4fe7-8442-58f41a05d2af", "ip_address": "192.168.102.2"} |
| 40857daa-17c7-4772-9d08-00545dfa2d1a | VNF_UPG_03_PL3_eth5 | fa:16:3e:c8:26:9f | {"subnet_id": "5d655edc-3f58-446f-8f69-73843e022bd7", "ip_address": "192.168.104.2"} |
| 45100e65-0ae6-45e5-a9df-02b2c5998ee2 | VNF_UPG_03_PL3_eth0 | fa:16:3e:73:de:e8 | {"subnet_id": "45d0c3dd-ff7e-4a0b-a792-018cdbc0fcd4", "ip_address": "192.168.100.2"} |
| d40dbe59-43e6-4c9b-ae33-6e4ba1998153 | VNF_UPG_03_PL3_eth4 | fa:16:3e:e2:bf:1f | {"subnet_id": "9ad4da70-4d7b-4ac7-b435-1936e981a3a5", "ip_address": "192.168.103.2"} |

atlasadm@atlas:~$ nova interface-list VNF_UPG_03_PL3
+------------+--------------------------------------+--------------------------------------+---------------+-------------------+
| Port State | Port ID                              | Net ID                               | IP addresses  | MAC Addr          |
+------------+--------------------------------------+--------------------------------------+---------------+-------------------+
| ACTIVE     | 2f1fd9bd-cbd7-4a4d-87c1-8da44bccfbd5 | 4a99c67c-b076-4f06-ab03-c96ae9e0199f | 192.168.102.2 | fa:16:3e:e2:26:f8 |
| ACTIVE     | 40857daa-17c7-4772-9d08-00545dfa2d1a | a29e1a0d-2c5d-4746-a92c-898b12b48149 | 192.168.104.2 | fa:16:3e:c8:26:9f |
| ACTIVE     | 45100e65-0ae6-45e5-a9df-02b2c5998ee2 | 5a2c4a9a-9a57-4347-ab57-23afe254492e | 192.168.100.2 | fa:16:3e:73:de:e8 |
| ACTIVE     | d40dbe59-43e6-4c9b-ae33-6e4ba1998153 | be23cead-a782-4c54-bdae-788e9ff5e791 | 192.168.103.2 | fa:16:3e:e2:bf:1f |
+------------+--------------------------------------+--------------------------------------+---------------+-------------------+


## Shutdown VM

atlasadm@atlas:~$ nova list
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| ID                                   | Name           | Status | Task State | Power State | Networks                                                                                                              |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| 0342daaf-e609-4371-9ca2-42c70dd8cbe4 | VNF_UPG_03_PL3 | ACTIVE | -          | Running     | internal_network=192.168.100.2; LDAP_network=192.168.103.2; PROV_network=192.168.104.2; Traffic_network=192.168.102.2 |
| dfe248fd-1a68-45e7-81b6-c36090390d99 | VNF_UPG_03_PL4 | ACTIVE | -          | Running     | internal_network=192.168.100.1; LDAP_network=192.168.103.3; PROV_network=192.168.104.3; Traffic_network=192.168.102.3 |
| 0b4ec169-db95-465b-8664-b167d0e9de95 | VNF_UPG_03_SC1 | ACTIVE | -          | Running     | internal_network=192.168.100.3; vUPG SYSOAM network=10.170.59.24; NBI_OAM_network=192.168.101.3                       |
| eef926e9-e3d1-4279-bb89-1f0d73e3ddfe | VNF_UPG_03_SC2 | ACTIVE | -          | Running     | internal_network=192.168.100.4; vUPG SYSOAM network=10.170.59.25; NBI_OAM_network=192.168.101.2                       |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
atlasadm@atlas:~$ nova stop VNF_UPG_03_PL4
Request to stop server VNF_UPG_03_PL4 has been accepted.
atlasadm@atlas:~$

atlasadm@atlas:~$ nova list
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| ID                                   | Name           | Status  | Task State | Power State | Networks                                                                                                              |
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| 0342daaf-e609-4371-9ca2-42c70dd8cbe4 | VNF_UPG_03_PL3 | ACTIVE  | -          | Running     | internal_network=192.168.100.2; LDAP_network=192.168.103.2; PROV_network=192.168.104.2; Traffic_network=192.168.102.2 |
| dfe248fd-1a68-45e7-81b6-c36090390d99 | VNF_UPG_03_PL4 | SHUTOFF | -          | Shutdown    | internal_network=192.168.100.1; LDAP_network=192.168.103.3; PROV_network=192.168.104.3; Traffic_network=192.168.102.3 |
| 0b4ec169-db95-465b-8664-b167d0e9de95 | VNF_UPG_03_SC1 | ACTIVE  | -          | Running     | internal_network=192.168.100.3; vUPG SYSOAM network=10.170.59.24; NBI_OAM_network=192.168.101.3                       |
| eef926e9-e3d1-4279-bb89-1f0d73e3ddfe | VNF_UPG_03_SC2 | ACTIVE  | -          | Running     | internal_network=192.168.100.4; vUPG SYSOAM network=10.170.59.25; NBI_OAM_network=192.168.101.2                       |
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
atlasadm@atlas:~$
atlasadm@atlas:~$ nova start VNF_UPG_03_PL4
Request to start server VNF_UPG_03_PL4 has been accepted.
atlasadm@atlas:~$ nova list
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| ID                                   | Name           | Status | Task State | Power State | Networks                                                                                                              |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| 0342daaf-e609-4371-9ca2-42c70dd8cbe4 | VNF_UPG_03_PL3 | ACTIVE | -          | Running     | internal_network=192.168.100.2; LDAP_network=192.168.103.2; PROV_network=192.168.104.2; Traffic_network=192.168.102.2 |
| dfe248fd-1a68-45e7-81b6-c36090390d99 | VNF_UPG_03_PL4 | ACTIVE | -          | Running     | internal_network=192.168.100.1; LDAP_network=192.168.103.3; PROV_network=192.168.104.3; Traffic_network=192.168.102.3 |
| 0b4ec169-db95-465b-8664-b167d0e9de95 | VNF_UPG_03_SC1 | ACTIVE | -          | Running     | internal_network=192.168.100.3; vUPG SYSOAM network=10.170.59.24; NBI_OAM_network=192.168.101.3                       |
| eef926e9-e3d1-4279-bb89-1f0d73e3ddfe | VNF_UPG_03_SC2 | ACTIVE | -          | Running     | internal_network=192.168.100.4; vUPG SYSOAM network=10.170.59.25; NBI_OAM_network=192.168.101.2                       |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
atlasadm@atlas:~$
atlasadm@atlas:~$ nova stop VNF_UPG_03_SC1
Request to stop server VNF_UPG_03_SC1 has been accepted.
atlasadm@atlas:~$ nova list
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| ID                                   | Name           | Status  | Task State | Power State | Networks                                                                                                              |
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| 0342daaf-e609-4371-9ca2-42c70dd8cbe4 | VNF_UPG_03_PL3 | ACTIVE  | -          | Running     | internal_network=192.168.100.2; LDAP_network=192.168.103.2; PROV_network=192.168.104.2; Traffic_network=192.168.102.2 |
| dfe248fd-1a68-45e7-81b6-c36090390d99 | VNF_UPG_03_PL4 | ACTIVE  | -          | Running     | internal_network=192.168.100.1; LDAP_network=192.168.103.3; PROV_network=192.168.104.3; Traffic_network=192.168.102.3 |
| 0b4ec169-db95-465b-8664-b167d0e9de95 | VNF_UPG_03_SC1 | SHUTOFF | -          | Shutdown    | internal_network=192.168.100.3; vUPG SYSOAM network=10.170.59.24; NBI_OAM_network=192.168.101.3                       |
| eef926e9-e3d1-4279-bb89-1f0d73e3ddfe | VNF_UPG_03_SC2 | ACTIVE  | -          | Running     | internal_network=192.168.100.4; vUPG SYSOAM network=10.170.59.25; NBI_OAM_network=192.168.101.2                       |
+--------------------------------------+----------------+---------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+

atlasadm@atlas:~$ nova start VNF_UPG_03_SC1
Request to start server VNF_UPG_03_SC1 has been accepted.
atlasadm@atlas:~$ nova list
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| ID                                   | Name           | Status | Task State | Power State | Networks                                                                                                              |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
| 0342daaf-e609-4371-9ca2-42c70dd8cbe4 | VNF_UPG_03_PL3 | ACTIVE | -          | Running     | internal_network=192.168.100.2; LDAP_network=192.168.103.2; PROV_network=192.168.104.2; Traffic_network=192.168.102.2 |
| dfe248fd-1a68-45e7-81b6-c36090390d99 | VNF_UPG_03_PL4 | ACTIVE | -          | Running     | internal_network=192.168.100.1; LDAP_network=192.168.103.3; PROV_network=192.168.104.3; Traffic_network=192.168.102.3 |
| 0b4ec169-db95-465b-8664-b167d0e9de95 | VNF_UPG_03_SC1 | ACTIVE | -          | Running     | internal_network=192.168.100.3; vUPG SYSOAM network=10.170.59.24; NBI_OAM_network=192.168.101.3                       |
| eef926e9-e3d1-4279-bb89-1f0d73e3ddfe | VNF_UPG_03_SC2 | ACTIVE | -          | Running     | internal_network=192.168.100.4; vUPG SYSOAM network=10.170.59.25; NBI_OAM_network=192.168.101.2                       |
+--------------------------------------+----------------+--------+------------+-------------+-----------------------------------------------------------------------------------------------------------------------+
atlasadm@atlas:~$


### expected result
SC-1:~ # dvemon status -a
        SC-1                               SC-2                               PL-3                               PL-4
========================           ========================           ========================           ssh: connect to host pl-4 port
   Application Server                 Application Server                 Application Server              1022: Connection timed out
========================           ========================           ========================
dge-domain running                 dge-domain running                 dge-domain running
GUI port(6262) enabled             GUI port(6262) enabled             Traffic port(6060) enabled
SSL GUI port(6363) enabled         SSL GUI port(6363) enabled         Traffic SSL port(6161) enabled
========================           ========================           Provision port(6262) enabled
      ZOOKEEPER                          ZOOKEEPER                    Provision SSL port(6363) enabled
========================           ========================           LDAP traffic port(6389) enabled
ZooKeeper is running               ZooKeeper is running               LDAPS traffic port(6636) enabled
                                                                      MAP traffic is enabled
                                                                      Diameter Sh traffic is enabled
                                                                      ========================
                                                                            ZOOKEEPER
                                                                      ========================
                                                                      ZooKeeper is running
                                                                      ========================
                                                                            SS7 CAF
                                                                      ========================
                                                                      SS7 CAF is running



                                                                      SC-1:~ # dvemon status -a
                                                                              SC-1                               SC-2                               PL-3                               PL-4
                                                                      ========================           ========================           ========================           ========================
                                                                         Application Server                 Application Server                 Application Server                 Application Server
                                                                      ========================           ========================           ========================           ========================
                                                                      dge-domain running                 dge-domain running                 dge-domain running                 dge-domain running
                                                                      GUI port(6262) enabled             GUI port(6262) enabled             Traffic port(6060) enabled         Traffic port(6060) enabled
                                                                      SSL GUI port(6363) enabled         SSL GUI port(6363) enabled         Traffic SSL port(6161) enabled     Traffic SSL port(6161) enabled
                                                                      ========================           ========================           Provision port(6262) enabled       Provision port(6262) enabled
                                                                            ZOOKEEPER                          ZOOKEEPER                    Provision SSL port(6363) enabled   Provision SSL port(6363) enabled
                                                                      ========================           ========================           LDAP traffic port(6389) enabled    LDAP traffic port(6389) enabled
                                                                      ZooKeeper is running               ZooKeeper is running               LDAPS traffic port(6636) enabled   LDAPS traffic port(6636) enabled
                                                                                                                                            MAP traffic is enabled             MAP traffic is enabled
                                                                                                                                            Diameter Sh traffic is enabled     Diameter Sh traffic is enabled
                                                                                                                                            ========================           ========================
                                                                                                                                                  ZOOKEEPER                          SS7 CAF
                                                                                                                                            ========================           ========================
                                                                                                                                            ZooKeeper is running               SS7 CAF is running
                                                                                                                                            ========================
                                                                                                                                                  SS7 CAF
                                                                                                                                            ========================
                                                                                                                                            SS7 CAF is running
