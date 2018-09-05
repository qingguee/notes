## ADP design


### 

The areas to SOC towards for this planned ADP GS PRA release now in Q2 have been updated by the Chief Architect and are listed under this section
Provide a first version of an ADP Service  Confluence
As you will see the list is short and not pointing towards a specific Design rule – these are areas that needs to be fulfilled and you should plan and SOC towards
Provide a first version of an ADP Service
The following list defines what needs to be addressed to provide the service to the ADP ecosystem. It also gives references to that design rules it will fulfill.
Container base OS must be based on RHEL
- Must be delivered as an image following the Docker container format
- Must be possible to instantiate within a container
- Must use semantic versioning, and using a major number of '0' as long as the service is considered to be in an initial development phase (unstable)
- Must provide network based interface(s)
- Must follow the defined HELM chart guidelines
= Must follow the e2e CICD Design Rules
In early stage of the service development, the provided interface can be considered unstable and is allowed to be changed in any way. However, as soon as the interfaces is considered stable enough for a first sharp release the follow additional aspect must also be addressed:
- All interfaces shall be version controlled and backward compatible