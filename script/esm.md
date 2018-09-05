# ESM (SWM 2.0 in CBA)

## Todo
- [ ] What is runtime and depolyment concept in CBA?
- [ ] What is current installation and packaging in UPG? RPM->SDP-> campaigns?


[ESM Workshop with UDM CLOUD community](https://play.ericsson.net/media/t/1_c8suo9w9)

[CBA - ESM](https://play.ericsson.net/media/t/0_twi1oyyu)
[Enhanced Software Management introduction](https://play.ericsson.net/media/t/1_fguqxe3m)
## Vocabulary
ESM - Enhanced Software Management
CSM - CBA System Model


## 2033 env 
 sudo mount -t cifs //vhub.sh.cn.ao.ericsson.se/proj/upg /workspace/upg -o username=elluffn,uid=1000,gid=1000,iocharset=utf8,sec=ntlm
 

## DX tools


## AM password Encrypted
https://wiki.lmera.ericsson.se/wiki/X-CI_Authentication#HTTP_GET_Requests

Encrypted password

Get your encrypted password by logging into the Artifactory Web Frontend at

https://arm.rnd.ki.sw.ericsson.se/artifactory/webapp/login.html

Go to your user profile:

https://arm.rnd.ki.sw.ericsson.se/artifactory/webapp/#/profile

Enter your password to unlock. Copy your encrypted password. 

### CSM Modeling tools
- csmcli -- used to create CSM instance document
- csmlint -- used to validate CSM instance document against a CSM schema
- csmconfig: Tool to fetch the configuration, files referenced in the CSM model and create the CSM directory layout files. To extract unset parameters and merge the contents to OVF template file.
- camp2csm: To transform a campaign to a CSM model


### CSM transformation tools
- CSM2CSP: Tools that transforms the CSM model information(CSM directory Layout) to the required information for UPT/CSPT(CSP directory layout)
- CSM2KIWI: Tools that transforms the CSM model information(CSM directory Layout) to the required information for KIWI(KIWI directory layout)

### TCG -- Target Configuration Generator 

### Packaging
UPT/CSPT : Tool to create CBA Software Package (CSP) which would be consumed by AIT for initial deployment and by ECIM CLI  for system upgrade
AIT: Tool to generate AIT ISO file, which would be used for initial deployment of the CBA software

### Deployment
AIT: Tool to consume the CSP package to install the software.(Initial installation)



## create CSP
cpt create --package-type deployment --component-version 1.0.0 \
--component-name glassfish --distro sle \
--product-number cxs1034009 \
--input-dir dp

cpt create --package-type runtime --component-version 1.0.0 \
--component-name glassfish --distro sle \
--product-number cxs1034009 \
--input-dir rt

## Create CSM

### Create component
csmcli component-create glassfish.3pp.cfg \
 --name glassfish.3pp.cfg --description "3pp Glashfish configuraiton" \
 --availability-manager AMF  \
 --control-policy-type  SIMPLE --node-active MANY \
 --node-standby  NONE --cluster-active MANY --cluster-standby NONE \
 --start "/opt/dve/bin/upgGlassfish_init start" \
 --stop  "/opt/dve/bin/upgGlassfish_init stop" 

 --software-sdp ERIC-EVIP-CXP9017652_3

### Update component
 csmcli component-update test.cba.mgr
    --name CbaManager 
    --description "TEST CBA MANAGER"  
    --availability-manager AMF  
    --software-sdp ERIC-TEST-CXP9017652_3 
    --control-policy-type  ADVANCED 
    --node-active ONE 
    --node-standby  ONE 
    --cluster-active ONE
    --cluster-standby ONE 
    --start "/opt/vip/bin/test_control.sh instantiate" 
    --stop  "/opt/vip/bin/test_control.sh cleanup
components 'test.cba.mgr' updated

### Mata data
  meta-data:
    component-version: 2.7.0.2
    deliverable:
      deployment-package: glassfishcfg-2.7.0.2-deployment-sle-cxs1034009.tar.gz
      runtime-package: glassfishcfg-2.7.0.2-runtime-sle-cxs1034009.tar.gz
    software:
    - file-name: GlassFish-LOTC-CFG-CXS1034009_0-R9A02-2.0.7.2.rpm
      bundle-name: 3PP-GlassFish-LOTC-CFG-CXS1034009


### component-add-constraints-installation-after
 csmcli component-add-constraints-installation-after glassfish.3pp.cfg \
   --component glassfish.3pp.main --method DIFFERENT-STEP 


### Build.sh

copyRpmFilesFromNexus()
  - remove POSTGRESQLPOSTGRESQL 
  - 

copyCBAFiles()
  - Should be remove or reaplaced by createCBAFiles.

BuildSdps() 
  - Should be removed

copyConfigFiles()
  - #Copy files for AIT installation



### ESM Iterms

- Create CSM for each UPG components
    - Create Depolyment tar.gz file
      - Create CSM for each UPG SW
      - Create CSM structure 
    - Create Runtime tar.gz file
      - Create runtime folder for each SW or use same tempory folder for creating runtime file?

- Build.sh modify
  - Remove SDP related actions
  - Build runtime package
  - Build depolyement pakckage 

- Installation.sh
  - create Bash rpm
  - Review the script for new AIT installations. 

- CI update
  - Update UPG_Management.sh for new AIT installation 


## GIT structure

### UPG base ESM system  
ISO/install/ESM/
├── CBA
│   └── versions.xml
├── UPG
│   └── system.xml
└── User360
    └── system.xml

3 directories, 3 files

### ESM workspace

prov-b1/ISO/target/ESMworkspace/    <<== will be removed after CSP pakcge ready.
├── .AMcash
├── AM_WORKSPACE
│   └── ArtifactManager.cfg   <<== Need setup user account for XCI
├── CSM_WORKSPACE
├── output
│   ├── csp-package    <<== copy to ISO/target/csp-package or Directly output to ISO/target/csp-package
│   └── RT-version
└── repo
    ├── DT        <<== Could be reset to CR/sw Or create a soft link to CR/sw. ? Create depolyment.tar.gz or not
    └── RT        <<== Script to create runtime csp in this folder

9 directories, 1 file


### UPG SW
prov-b1/CR/sw/ZooKeeper
├── rpm.spec
├── Zookeeper-depolyment
│   ├── csm
│   │   ├── config
│   │   │   └── initial
│   │   ├── plugin
│   │   └── zookeeper-csm.yml                  <<== Update version info by script
│   └── csm.metadata
└── Zookeeper-runtime
    └── zookeeper-3.4.6.x86_64.rpm

6 directories, 4 files

prov-b1/CR/sw/Business-Logic/Business-Logic-System
├── Business-Logic-System
│   ├── pom.xml
│   └── target
│       ├── commons-logging-1.1.1.jar
│       ├── JDV-CUDB-ElimLM-17.4.22-SNAPSHOT.jar
│       ├── JDV-UPG-NODECONFIG-17.4.22-SNAPSHOT.jar
│       ├── junit-4.10.jar
│       ├── log4j-1.2.16.jar
│       ├── org.jacoco.agent-0.6.3.201306030806-runtime.jar
│       ├── slf4j-api-1.7.6.jar
│       └── slf4j-log4j12-1.7.6.jar
├── Business-Logic-System-depolyment
│   └── csm
│       ├── Business-Logic-System-csm.yml     <<== Update version info by script
│       ├── config
│       │   └── initial
│       └── plugin
├── Business-Logic-System-runtime               <<=== Output RPM in this folder, then copy to ESMworkspace/repo/RT
└── rpm.spec

8 directories, 11 files


### CSP package output
prov-b1/ISO/target/csp-package
├── CBA_UPG.tar.gz
└── CBA_UPG_User360.tar.gz

0 directories, 2 files





### RPMs 

[95caf5a06fc5 ISO]# tree target/
target/
|-- Common3ppPlatform
|   `-- rpm
|       |-- GlassFish-1.0.0.rpm
|       |-- GlassFish-LOTC-CFG-2.0.7.rpm
|       |-- SENTINEL-64-2.1.0.rpm
|       |-- SENTINEL-LOTC-CFG-2.0.18.rpm
|       |-- Termcap-64-2.0.8.rpm
|       |-- bash-3.2-147.22.1.x86_64.rpm
|       |-- bash-doc-3.2-147.22.1.x86_64.rpm
|       |-- libreadline5-32bit-5.2-147.22.1.x86_64.rpm
|       |-- libreadline5-5.2-147.22.1.x86_64.rpm
|       `-- readline-doc-5.2-147.22.1.x86_64.rpm
`-- UserProfileGateway
    |-- BASH
    |   |-- bash-3.2-147.22.1.x86_64.rpm
    |   |-- bash-doc-3.2-147.22.1.x86_64.rpm
    |   |-- libreadline5-32bit-5.2-147.22.1.x86_64.rpm
    |   |-- libreadline5-5.2-147.22.1.x86_64.rpm
    |   `-- readline-doc-5.2-147.22.1.x86_64.rpm
    `-- rpm
        |-- Canal-LOTC-CFG-R11A02-0.x86_64.rpm
        |-- DGE-CORE-R19A02-0.x86_64.rpm
        |-- DGE-Common-R19A02-0.x86_64.rpm
        |-- DGE-DS-User360-Presentation-R12A02-0.x86_64.rpm
        |-- DGE-DS-User360-Service-R13A02-0.x86_64.rpm
        |-- DGE-EVIP-CFG-R11A02-0.x86_64.rpm
        |-- DGE-GUI-OM-R19A02-0.x86_64.rpm
        |-- DGE-Glassfish-Domain-DGE-R15A02-0.x86_64.rpm
        |-- DGE-Inbound-HTTP-R14A02-0.x86_64.rpm
        |-- DGE-Inbound-LDAP-R15A02-0.x86_64.rpm
        |-- DGE-Inbound-MAP-R13A02-0.x86_64.rpm
        |-- DGE-Inbound-RG-R16A02-0.x86_64.rpm
        |-- DGE-Inbound-Sh-R11A02-0.x86_64.rpm
        |-- DGE-Outbound-CAI3G-R13A02-0.x86_64.rpm
        |-- DGE-Outbound-Diameter-SH-R17A02-0.x86_64.rpm
        |-- DGE-Outbound-FTP-R14A02-0.x86_64.rpm
        |-- DGE-Outbound-HTTP-R17A02-0.x86_64.rpm
        |-- DGE-Outbound-JDBC-R14A02-0.x86_64.rpm
        |-- DGE-Outbound-LDAP-R17A02-0.x86_64.rpm
        |-- DGE-Outbound-LDAPS-R13A02-0.x86_64.rpm
        |-- DGE-Outbound-SSH-R14A02-0.x86_64.rpm
        |-- DGE-Outbound-TELNET-R13A02-0.x86_64.rpm
        |-- DGE-Tools-R16A02-0.x86_64.rpm
        |-- DGE-Traffic-Control-R16A02-0.x86_64.rpm
        |-- DiameterService-R13A02-0.x86_64.rpm
        |-- Drill-LOTC-CFG-R11A02-0.x86_64.rpm
        |-- FreshDB-LOTC-CFG-R11A02-0.x86_64.rpm
        |-- LOTC-CFG-R9A02-0.x86_64.rpm
        |-- UPG-BL-EXAMPLE-R8A02-0.x86_64.rpm
        |-- UPG-BL-MAPPING_FILES-R8A02-0.x86_64.rpm
        |-- UPG-BL-SSSYNC-R8A02-0.x86_64.rpm
        |-- UPG-BL-SYSTEM-R8A02-0.x86_64.rpm
        |-- UPG-BL-USER360_PROFILE_ANALYTICS-R8A02-0.x86_64.rpm
        |-- UPG-BL-USER360_PROFILE_VIEWER-R8A02-0.x86_64.rpm
        |-- Upg-Monitor-R11A02-1.x86_64.rpm
        |-- User360-R12A02-0.x86_64.rpm
        |-- ZooKeeper-LOTC-CFG-R14A02-0.x86_64.rpm
        |-- canal-1.0.22.1-x86_64.rpm
        |-- drill-1.7.2-x86_64.rpm
        |-- expect-5.45-15.89.x86_64.rpm
        |-- jdk-7u131-linux-x64.rpm
        |-- mysql-advanced-5.7.11-linux-glibc2.5-x86_64.rpm
        |-- mysql-connector-python-2.1.3-1.sles12.x86_64.rpm
        `-- zookeeper-3.4.6.x86_64.rpm

5 directories, 59 files


## ESMworkspace/repo/RT/
[elluffn@manjaro data]$ tree prov-b1/ISO/target/ESMworkspace/repo/RT/
prov-b1/ISO/target/ESMworkspace/repo/RT/
├── canal-1.9.0-runtime-sle-cxp123456.tar.gz
├── com_x86_64-7.4.0-26-runtime-sle-cxp9028493.tar.gz
├── coremw_x86_64-4.5.0-277-deployment-sle-cxp9017564.tar.gz
├── coremw_x86_64-4.5.0-277-runtime-sle-cxp9020355.tar.gz
├── CSM_PLUGIN.tar.gz
├── csp.log
├── drill-1.9.0-runtime-sle-cxp123456.tar.gz
├── evip-3.5.0-67-runtime-sle-cxp9020395.tar.gz
├── expect-1.9.0-runtime-sle-cxp123456.tar.gz
├── freshdb-1.9.0-runtime-sle-cxp123456.tar.gz
├── jdk64-1.9.0-runtime-sle-cxp123456.tar.gz
├── ldews-4.3.1-2-runtime-sle-cxp9020125.tar.gz
├── lm-6.3.0-90-runtime-sle-cxp9020396.tar.gz
├── lmsa-2.4.0-3-runtime-sle-cxp9021377.tar.gz
├── mysqlconnector-1.9.0-runtime-sle-cxp123456.tar.gz
├── sec-acs-2.5.0-082-runtime-sle-cxp9026450.tar.gz
├── sec-cert-2.5.0-082-runtime-sle-cxp9027891.tar.gz
├── sec-crypto-2.5.0-082-runtime-sle-cxp9027895.tar.gz
├── sec-ldap-2.5.0-082-runtime-sle-cxp9028981.tar.gz
├── sec-secm-2.5.0-082-runtime-sle-cxp9028976.tar.gz
├── tmp
├── version_updated.xml
└── workspace


## build.sh ESM env



## ESM issues

### 

Please close the JIRA case!

FYI: I mixed SWM1.0 (CBA SET) install with SWM2.0 (LEM/DBS) installation, and probably the reason of the mismatch was the coremw_defaultScale_2+2.config.xml.

<roles>
<role name="Default-Role" scalable="true" autoAssigned="true" />
</roles>
<system>
<instance name="PL-3" providedRole="Default-Role" />
<instance name="PL-4" providedRole="Default-Role" />
</system>
</deploymentConfiguration>

CMW behaviour: "If the default role is initially assigned to more than one node, the EE picks a random node to be a template node."

FYI: I reinstalled the whole CBA stack with ESM, and the scaleout was successful afterwards.
Anyhow we will prefer akind of mixed SWM1.0/SWM2.0 scenario in order not to loose exisitng backups, so probably I will modify the coremw_defaultScale_2+2.config.xml to something like this later on:

<roles>
<role name="Non-scalable-Role" scalable="false" autoAssigned="true" />
<role name="Default-Role" scalable="true" autoAssigned="true" />
</roles>
<system>
<instance name="PL-3" providedRole=" Non-scalable-Role " />
<instance name="PL-4" providedRole="Default-Role" />
</system>
</deploymentConfiguration>


./unpack/plugin/coremw_x86_64-4.5.0-277-deployment-sle-cxp9017564/sle12/template/defaultScale.config                                                                                                          
./unpack/lm/coremw_x86_64-4.5.0-277-runtime-sle-cxp9020355/sle12/template/defaultScale.config 


## Replace template

sed "s/%{UPG_SW_NAME}/upg.3pp.jdk64/g" /workspace/docker/esm/data/prov-b1/CR/3PP-Platform/sw/bundles/jdk64/csm/csm.yml


## Hands on
This is a example how we create a non AMF csm for JDK64.
Target Goal:
- Example: Create a CSM structure a for new component via esm_skeleton.sh.
- Example: Create a NONE AMF component jdk64. 
- Example: Add jdk64 to build.sh to build runtime and deployment packages. 
- Example: Build CSP package which include CBA+jdk64 component. 

#### Create a CSM structure a for new component via esm_skeleton.sh 
```
[c8ead2ebbeb3 ESM]# pwd
/data/prov-b1/ISO/install/ESM

[c8ead2ebbeb3 ESM]# ./esm_skeleton.sh 
==================================ESM SKELETON================================================
./esm_skeleton.sh will create CSM skeleton for UPG SW conponents where rpm.spec located for each SW.
CR/sw folder will be used as local Depolyment repository for creating CSP package. 
Usage:    
      ./esm_skeleton.sh <options> <paramiters>
Options:  
      --upg or -u : Create UPG CSM skeleton at CR/sw.
          paramiter: <component name>
          paramiter: <csm id>
      --3pp : Create 3PP CSM skeleton at CR/3PP-Platform/sw/bundles.
          paramiter: <component name>
          paramiter: <csm id>
      --print or -p : Print SW folders for upg or 3pp
          paramiter: upg or 3pp
      --check or -c : Check exsiting CSM SW for upg or 3pp
          paramiter: upg or 3pp
Examples:
./esm_skeleton.sh -u ZooKeeper upg.3pp.zookeeper
./esm_skeleton.sh --upg Business-Logic/Business-Logic-Example upg.bl.example
./esm_skeleton.sh --3pp expect upg.3pp.expect
./esm_skeleton.sh -p 3pp
./esm_skeleton.sh --print 3pp
./esm_skeleton.sh -c upg
./esm_skeleton.sh --check upg
[c8ead2ebbeb3 ESM]# 

[elluffn@manjaro ESM]$ ./esm_skeleton.sh -u jdk64 upg.3pp.jdk64
===== Create UPG CSM skeleton at CR/sw. 
[elluffn@manjaro ESM]$ ./esm_skeleton.sh -c upg
===== Check exsiting CSM SW.
. 
[c8ead2ebbeb3 ESM]# ./esm_skeleton.sh -c 3pp
===== Check exsiting CSM SW.
.
/data/prov-b1/CR/3PP-Platform/sw/bundles/jdk64/deployment
[c8ead2ebbeb3 ESM]# cd /data/prov-b1/CR/3PP-Platform/sw/bundles/jdk64/deployment
[c8ead2ebbeb3 deployment]# cd ../..
[c8ead2ebbeb3 bundles]# tree jdk64/
jdk64/
|-- deployment
|   |-- csm
|   |   |-- config
|   |   |   `-- initial
|   |   |       `-- component
|   |   |           `-- component.conf
|   |   |-- csm.yml
|   |   `-- csm_backup
|   `-- csm.metadata
|-- pom.xml
|-- sdpfiles
|   `-- scripts
|       |-- offline-install
|       `-- offline-remove
`-- src
    `-- main
        `-- resources
            `-- templates
                `-- ETF.xml

11 directories, 8 files


```
#### Create a NONE AMF component jdk64
```
[c8ead2ebbeb3 csm]# pwd  
/data/prov-b1/CR/3PP-Platform/sw/bundles/jdk64/deployment/csm
[elluffn@manjaro csm]$ cp csm.yml csm_backup
## Update csm_backup
[c8ead2ebbeb3 csm]# vim csm_backup
[c8ead2ebbeb3 csm]# cat csm_backup 
csm-version: 1.0

components:

- uid: upg.3pp.jdk64
  name: upg.3pp.jdk64
  description: "upg.3pp.jdk64 component"
  software:
    rpms: 
    - %{RPM_NAME} 
  availability-manager: NONE
  meta-data:
    component-version: %{COMPONENT_VERSION}  
    deliverable:
      deployment-package: %{DEPLOYMENT_PACKAGE}
      runtime-package: %{RUNTIME_PACKAGE}
    software:
        - bundle-name: %{RPM_NAME}
          file-name: %{RPM_NAME}.rpm 
        
services:
      
- uid: upg.3pp.jdk64
  name: upg.3pp.jdk64
  description: "upg.3pp.jdk64 service"
  components:
    - name: upg.3pp.jdk64
      instance-of: upg.3pp.jdk64

functions:
- uid: upg.3pp.jdk64 
  version: 1.9.0 
  name: upg.3pp.jdk64
  description: 
       "upg.3pp.jdk64 function"
  services:
    - upg.3pp.jdk64
[c8ead2ebbeb3 csm]# 

```

#### Add jdk64 to build.sh to build runtime and deployment packages
Add jdk64 to createCXAPackage()  function.
```
createCBAPackages()
{
	#* Declare 
	UPG_RPM_STORE=${DVE_SRCVOB}/ISO/target/UserProfileGateway/rpm/
	ThirtParty_STORE=${DVE_SRCVOB}/ISO/target/Common3ppPlatform/rpm/
	UPG_SW_SRC=${DVE_SRCVOB}/CR/sw/
	ThirtParty_SRC=${DVE_SRCVOB}/CR/3PP-Platform/sw/bundles/

	echo "create UPG runtime packages"
	#!! Note: When building new component, beware compName. 
	#!! For example: 
	#!! 	*3pp will use lower case (jdk64).
	#!! 	*UPG will use Upper case (e.g LOTC-CFG) or First letter Upper case (e.g. UPG-Monitor). 
	# BuildRuntimePackage <compName> <compProductNo> <RPM_STORE> 
	BuildRuntimePackage jdk64 ${JDK64_PRODUCT_NO} ${UPG_RPM_STORE} 
	# updateCSMYml <compName_dir in SW_SRC> <RPM_STORE> <SW_SRC where is Deployment repo>
	updateCSMYml jdk64 $UPG_RPM_STORE $ThirtParty_SRC
	# BuildDeploymentPackage <compName> <compProductNo> <SW_SRC where is Deployment repo>
	BuildDeploymentPackage jdk64 ${JDK64_PRODUCT_NO} $ThirtParty_SRC
}

```

#### Build CSP package which include CBA+jdk64 component
```
[c8ead2ebbeb3 ISO]# ./build.sh -test UPG noTest
Skipping test....
Running: mvn clean package -P MA60,UPG -Dmaven.test.skip=true 
[INFO] Scanning for projects...
.......
STEP: Creating Package ...
csp-swdp-version specified in SWDP file is: 2.0.0
Package created successfully in the output directory /data/prov-b1/ISO/target/ESMworkspace/output/csp-package/
Copying CBA_UPG.tar.gz to /data/prov-b1/ISO/target/csp-package/
CSP file: /data/prov-b1/ISO/target/csp-package/CBA_UPG.tar.gz

```

#### Deploy the CSP package to vCluster via AIT server(vm)
For manual deployment, please refer to 
- [DX Toolbox Automatic Installation Tool User Guide](http://calstore.internal.ericsson.com/alexserv?AC=LINKEXT&LI=EN/LZN7020441/1R5A&FN=1_1553-CXP9020536_2Uen.C.html)
- [RDA BSP Installation Instruction](http://calstore.internal.ericsson.com/alexserv?AC=LINKEXT&LI=EN/LZN7070237R5B&FN=28_1531-APR9010329_3Uen.F.html)

On our HUB 2033, we can use ansible to deploy the CSP package to vCluster via AIT. 
```
# On your build server, copy CSP file to upg project share folder 
# elluffn @ manjaro in /workspace/docker/esm [17:05:17] 
$ cp data/prov-b1/ISO/target/csp-package/CBA_UPG.tar.gz /media/upg/tmp/elluffn/CBA_UPG.tar.gz

#On HUB 2033
upg@ecnshlx2033:~$ pwd
/home/upg
upg@ecnshlx2033:~$ ansible-playbook ansible_deploy_cluster2.yml 

```


### PM FM to RPM
Installation :
sdp_path=/storage/system/software/coremw/repository
sdp_name=ERIC-PMCfg
ERIC-FMAlarmCfg

Rpm.spec : Extract rpm content to /opt/dve-repo/OAM/

Install.sh: (steps follow cbainstall.sh)
Copy FM/sdpfiles to  /storage/system/software/coremw/repository/UPG-FM-Model
Copy PM/sdpfiles to /storage/system/software/coremw/repository/UPG-PM-Model
Cmw-addtoIMM 	
createUPGPmjob "UPGPmJob“
refreshFMPM

#### B4
[elluffn@manjaro OAM]$ tree 
.
├── FM
│   ├── pom.xml
│   ├── sdpfiles
│   │   ├── com-model.config
│   │   ├── imm-model.config
│   │   ├── modules
│   │   │   ├── UPGFmModel_mp.xml
│   │   │   ├── UPGFmMOM_immR2_classes.xml
│   │   │   ├── UPGFmMOM_mp.xml
│   │   │   ├── UPGFmMOMUPGFmInstances_immR2_objects.xml
│   │   │   └── UPGFmMOMUPGFmInstances_mp.xml
│   │   └── scripts
│   │       ├── offline-install
│   │       └── offline-remove
│   └── src
│       └── main
│           └── resources
│               └── templates
│                   └── ETF.xml
├── Modeling
│   ├── README
│   ├── UPGCBAModels.rar
│   ├── UPGFmModel.rar
│   └── UPGPmModel.rar
└── PM
    ├── pom.xml
    ├── sdpfiles
    │   ├── com-model.config
    │   ├── imm-model.config
    │   ├── modules
    │   │   ├── UPGPmModel_mp.xml
    │   │   ├── UPGPmMOM_immR2_classes.xml
    │   │   ├── UPGPmMOM_mp.xml
    │   │   ├── UPGPmMOMUPGPmInstances_immR2_objects.xml
    │   │   └── UPGPmMOMUPGPmInstances_mp.xml
    │   └── scripts
    │       ├── offline-install
    │       └── offline-remove
    └── src
        └── main
            └── resources
                └── templates
                    └── ETF.xml

17 directories, 26 files

#### After
[elluffn@manjaro OAM]$ tree
.
├── FM
│   └── sdpfiles
│       ├── com-model.config
│       ├── ETF.xml
│       ├── imm-model.config
│       ├── modules
│       │   ├── UPGFmModel_mp.xml
│       │   ├── UPGFmMOM_immR2_classes.xml
│       │   ├── UPGFmMOM_mp.xml
│       │   ├── UPGFmMOMUPGFmInstances_immR2_objects.xml
│       │   └── UPGFmMOMUPGFmInstances_mp.xml
│       └── scripts
│           ├── offline-install
│           └── offline-remove
├── install.sh
├── Modeling
│   ├── README
│   ├── UPGCBAModels.rar
│   ├── UPGFmModel.rar
│   └── UPGPmModel.rar
├── PM
│   └── sdpfiles
│       ├── com-model.config
│       ├── ETF.xml
│       ├── imm-model.config
│       ├── modules
│       │   ├── UPGPmModel_mp.xml
│       │   ├── UPGPmMOM_immR2_classes.xml
│       │   ├── UPGPmMOM_mp.xml
│       │   ├── UPGPmMOMUPGPmInstances_immR2_objects.xml
│       │   └── UPGPmMOMUPGPmInstances_mp.xml
│       └── scripts
│           ├── offline-install
│           └── offline-remove
└── rpm.spec

### Create CSP

Create CSM
Selecet a UPG component from esm_cba_upg_systemdesign.xlsx
Create CSM folder structure 
prov-b1/ISO/install/ESM/esm_skeleton.sh
Create runtime and deployment package for the component in build.sh
Add component to UPG system in build.sh
Build CSP
