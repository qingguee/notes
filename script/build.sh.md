## build.sh

### env
    MYPWD=`pwd`
    cd `dirname $0`
    SCRIPT_HOME=`pwd`
    cd ..
    DVE_SRCVOB=`pwd`
    cd $MYPWD

    DEFAULT_ARCHITECTURE=x86_64


    DVE_BUILD_RESULT_C3PPP=${DVE_SRCVOB}/CR/3PP-Platform/target/
    DVE_RPM_SRC=${DVE_SRCVOB}/ISO
    DVE_RPM_SRC_CR=${DVE_SRCVOB}/CR/sw
    DVE_RPM_UPGRADE=${DVE_SRCVOB}/ISO/install/Baseline_Upgrade/scripts
    DVE_CUSTOMER_REP_RPM_STORE=${DVE_RPM_SRC}/target/CustomerRepository/rpm
    DVE_C3PPP_RPM_STORE=${DVE_RPM_SRC}/target/Common3ppPlatform/rpm
    DVE_C3PPP_STORE=${DVE_RPM_SRC}/target/Common3ppPlatform
    DVE_SS7CAF_STORE=${DVE_RPM_SRC}/target/UserProfileGateway/SS7CAF
    DVE_BASH_STORE=${DVE_RPM_SRC}/target/UserProfileGateway/BASH
    CBA_STORE=${DVE_RPM_SRC}/target/CBA

    prov-b1/ISO/                    //DVE_RPM_SRC
    prov-b1/ISO/target/           
    ├── CBA                         //CBA_STORE
    ├── Common3ppPlatform           //DVE_C3PPP_STORE
    │   └── rpm                     //DVE_C3PPP_RPM_STORE
    ├── CustomerRepository          //
    │   └── rpm                     //DVE_CUSTOMER_REP_RPM_STORE
    └── UserProfileGateway          
        ├── BASH                    //DVE_BASH_STORE
        └── SS7CAF                  //DVE_SS7CAF_STORE
        └── rpm                     //DVE_CUSTOMER_REP_RPM_STORE
    ESMworkspace                    //ESM_WORKSPACE

    prov-b1/CR/3PP-Platform/        //DVE_BUILD_RESULT_C3PPP
    prov-b1/CR/sw                   //DVE_RPM_SRC_CR

    prov-b1/ISO/target/ESMworkspace/    //ESM_WORKSPACE
    ├── .AMcash
    ├── AM_WORKSPACE
    │   └── ArtifactManager.cfg   
    ├── CSM_WORKSPACE
    ├── output
    │   ├── csp-package    
    │   └── RT-version
    └── repo
        ├── DT        
        └── RT              

## ESM workspace 
DVE_BUILD_RESULT_C3PPP=${DVE_SRCVOB}/CR/3PP-Platform/target/
DVE_RPM_SRC=${DVE_SRCVOB}/ISO
DVE_RPM_SRC_CR=${DVE_SRCVOB}/CR/sw
DVE_RPM_UPGRADE=${DVE_SRCVOB}/ISO/install/Baseline_Upgrade/scripts
DVE_CUSTOMER_REP_RPM_STORE=${DVE_RPM_SRC}/target/CustomerRepository/rpm
DVE_C3PPP_RPM_STORE=${DVE_RPM_SRC}/target/Common3ppPlatform/rpm
DVE_C3PPP_STORE=${DVE_RPM_SRC}/target/Common3ppPlatform
DVE_SS7CAF_STORE=${DVE_RPM_SRC}/target/UserProfileGateway/SS7CAF
DVE_BASH_STORE=${DVE_RPM_SRC}/target/UserProfileGateway/BASH
CBA_STORE=${DVE_RPM_SRC}/target/CBA
## ESM workspace 
DX_tools_env_script=/data/sourceDX.sh
ESM_WORKSPACE=${DVE_RPM_SRC}/target/ESMworkspace
AM_WORKSPACE=${ESM_WORKSPACE}/AM_WORKSPACE
CSM_WORKSPACE=${ESM_WORKSPACE}/CSM_WORKSPACE
RT_version_dir=${ESM_WORKSPACE}/output/RT_version
csp_output_dir=${DVE_RPM_SRC}/target/csp-package/
DT_repo=${DVE_RPM_SRC_CR}
RT_repo=${ESM_WORKSPACE}/repo/RT
ESM_AMcash=${AM_WORKSPACE}/.AMcash
# ESM input parameters
UPG_BASE_csp=CBA_UPG.tar.gz
UPG_FULL_csp=CBA_UPG_User360.tar.gz
CSP_version="CSP2.0"
ESM_SRC=DVE_RPM_SRC/ESM
ESM_input=${ESM_SRC}/input
ArtifactManager_CFG=${ESM_input}/ArtifactManager.cfg 
CBA_version=${ESM_SRC}/CBA/version.xml
UPG_base_system=${ESM_SRC}/UPG//system.yml
UPG_full_system=${ESM_SRC}/User360//system.yml       
### sub functions 
#####  -ALL)

1. BuildCustomerRepository UPG noTest
2. createRpmFiles UPG
3. copyRpmFilesFromNexus
4. copyCBAFiles
5. BuildSdps UPG        // to be replaced by CreateEsmPackage
6. copyConfigFiles UPG
7. copyExampleCode UPG
8. createIsoFile
9. moveIsoFile  

#### todo list
- [x] CreateEsmPackage //Hong Wei has completed.
- [ ] Update CR-Pack.csv
- [x] Create version files 
- [x] Create system.xml for UPG,360
- [ ] UPG runtime package creation 
- [ ] Esm_skeleton.sh for creating CSM folder structure
- [ ] Create CSP package for UPG and User360
- [ ] Remove CBA,BASH,user360 sdp,campaign from target/ISO
- [ ] Update UPG_Management //Baymax 
- [ ] ansible //Tick: Justin
- [ ] Update CPI for hardening after upgrade //Baymax
- [ ] Setup DX env for CI     //CI and Tick


