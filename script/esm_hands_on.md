
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
