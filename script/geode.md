# Geode


## Docker register
sudo docker pull armdocker.rnd.ericsson.se/proj-adp-gs-geode/opensuse:42.3
sudo docker push armdocker.rnd.ericsson.se/proj-adp-gs-geode/xxxx:z


armdocker.rnd.ericsson.se/sandbox/adp-staging/adp-gs/

## docker repo web
https://arm.epk.ericsson.se/artifactory/docker-v2-global-local/proj-adp-gs-geode/

push armdocker.rnd.ericsson.se/eric-data-key-value-database-ag/oql-test:0.0.1

https://arm.epk.ericsson.se/artifactory/docker-v2-global-local/proj-eric-data-key-value-database-ag
 
## Git repo
git clone https://elluffn@gerrit.ericsson.se/a/adp-gs/adp-gs-geode

## Helm repo 
PRA:  https://arm.rnd.ki.sw.ericsson.se/artifactory/proj-adp-helm-dev-generic-local/udm/datamanagement/
https://confluence.lmera.ericsson.se/display/ACD/How+to+upload+to+adp+helm+chart+repository#Howtouploadtoadphelmchartrepository-Firstupload 

### Reset Index
curl -k -H "X-JFrog-Art-Api: AKCp5Zkxbnwu5eezdN5AaY7SbZUx1rwEPfdohB9mJ38Zt6BUap4H7e8smvxCGz6JGpWSWH3kJ" -X PUT "https://arm.rnd.ki.sw.ericsson.se/artifactory/proj-adp-helm-dev-generic-local/udm/datamanagement/eric-data-key-value-database-ag/index.yaml" -T ./index.yaml


G

## Request 
Disable TCP SYN cookies. Most default Linux installations use SYN cookies to protect the system against malicious attacks that flood TCP SYN packets, but this feature is not compatible with stable and busy Geode clusters. Security implementations should instead seek to prevent attacks by placing Geode server clusters behind advanced firewall protection.

To disable SYN cookies permanently:

Edit the /etc/sysctl.conf file to include the following line:

net.ipv4.tcp_syncookies = 0
Setting this value to zero disables SYN cookies.

Reload sysctl.conf:

sysctl -p
See Disabling TCP SYN Cookies for details.

## gfsh help
```
gfsh>help                                                                                                                                                                                                     
alter async-event-queue (Available)                                                                                                                                                                           
    alter attributes of async-event-queue, needs rolling restart for new attributes to take effect.                                                                                                           
alter disk-store (Available)                                                                                                                                                                                  
    Alter some options for a region or remove a region in an offline disk store.                                                                                                                              
alter jdbc-connection (Available)                                                                                                                                                                             
    (Experimental) Alter properties for an existing jdbc connection.                                                                                                                                          
alter jdbc-mapping (Available)                                                                                                                                                                                
    (Experimental) Alter properties for an existing jdbc mapping.                                                                                                                                             
alter region (Available)                                                                                                                                                                                      
    Alter a region with the given path and configuration.                                                                                                                                                     
alter runtime (Available)                                                                                                                                                                                     
    Alter a subset of member or members configuration properties while running.                                                                                                                               
backup disk-store (Available)                                                                                                                                                                                 
    Perform a backup on all members with persistent data. The target directory must exist on all members, but can be either local or shared. This command can safely be executed on active members and is     
    strongly recommended over copying files via operating system commands.                                                                                                                                    
change loglevel (Available)                                                                                                                                                                                   
    This command changes log-level run time on specified servers.                                                                                                                                             
clear defined indexes (Available)                                                                                                                                                                             
    Clears all the defined indexes.                                                                                                                                                                           
close durable-client (Available)                                                                                                                                                                              
    Attempts to close the durable client, the client must be disconnected.                                                                                                                                    
close durable-cq (Available)
    Closes the durable cq registered by the durable client and drains events held for the durable cq from the subscription queue.
compact disk-store (Available)
    Compact a disk store on all members with that disk store. This command uses the compaction threshold that each member has configured for its disk stores. The disk store must have
    "allow-force-compaction" set to true.
compact offline-disk-store (Available)
    Compact an offline disk store. If the disk store is large, additional memory may need to be allocated to the process using the --J=-Xmx??? parameter.
configure pdx (Available)
    Configures Geode's Portable Data eXchange for all the cache(s) in the cluster. This command would not take effect on the running members in the system.
     This command persists the pdx configuration in the locator with cluster configuration service.
     This command should be issued before starting any data members.
connect (Available)
    Connect to a jmx-manager either directly or via a Locator. If connecting via a Locator, and a jmx-manager doesn't already exist, the Locator will start one.
create async-event-queue (Available)
    Create Async Event Queue.
create defined indexes (Available)
    Creates all the defined indexes.
create disk-store (Available)
    Create a disk store.
create gateway-receiver (Available)
    Create the Gateway Receiver on a member or members.                                                                                                                                                       
create gateway-sender (Available)                                                                                                                                                                             
    Create the Gateway Sender on a member or members.                                                                                                                                                         
create index (Available)                                                                                                                                                                                      
    Create an index that can be used when executing queries.                                                                                                                                                  
create jdbc-connection (Available)                                                                                                                                                                            
    (Experimental) Create a connection for communicating with a database through jdbc.                                                                                                                        
create jdbc-mapping (Available)                                                                                                                                                                               
    (Experimental) Create a mapping for a region for use with a JDBC database connection.                                                                                                                     
create lucene index (Available)                                                                                                                                                                               
    Create a lucene index that can be used to execute queries.                                                                                                                                                
create region (Available)                                                                                                                                                                                     
    Create a region with the given path and configuration. Specifying a --key-constraint and --value-constraint makes object type information available during querying and indexing.                         
debug (Available)                                                                                                                                                                                             
    Enable/Disable debugging output in GFSH.                                                                                                                                                                  
define index (Available)
    Define an index that can be used when executing queries.
deploy (Available)
    Deploy JARs to a member or members.  Only one of either --jar or --dir may be specified.
describe client (Available)
    Display details of specified client
describe config (Available)
    Display configuration details of a member or members.
describe connection (Available)
    Display information about the current connection.
describe disk-store (Available)
    Display information about a member's disk store.
describe jdbc-connection (Available)
    (Experimental) Describe the specified jdbc connection.
describe jdbc-mapping (Available)
    (Experimental) Describe the specified jdbc mapping.
describe lucene index (Available)
    Display the description of lucene indexes created for all members.
describe member (Available)
    Display information about a member, including name, id, groups, regions, etc.
describe offline-disk-store (Available)
    Display information about an offline disk store.
describe region (Available)
    Display the attributes and key information of a region.
destroy async-event-queue (Available)                                                                                                                                                                         
    destroy an Async Event Queue                                                                                                                                                                              
destroy disk-store (Available)                                                                                                                                                                                
    Destroy a disk store, including deleting all files on disk used by the disk store. Data for closed regions previously using the disk store will be lost.                                                  
destroy function (Available)
    Destroy/Unregister a function. The default is for the function to be unregistered from all members.
destroy gateway-sender (Available)
    Destroy the Gateway Sender on a member or members.
destroy index (Available)
    Destroy/Remove the specified index.
destroy jdbc-connection (Available)
    (Experimental) Destroy/Remove the specified jdbc connection.
destroy jdbc-mapping (Available)
    (Experimental) Destroy the specified mapping.
destroy lucene index (Available)
    Destroy the lucene index.
destroy region (Available)
    Destroy/Remove a region.
disconnect (Available)
    Close the current connection, if one is open.
echo (Available)                                                                                                                                                                                              
    Echo the given text which may include system and user variables.                                                                                                                                          
execute function (Available)                                                                                                                                                                                  
    Execute the function with the specified ID. By default will execute on all members.                                                                                                                       
exit (Available)
    Exit GFSH and return control back to the calling process.
export cluster-configuration (Available)
    Exports the cluster configuration artifacts as a zip file.
export config (Available)
    Export configuration properties for a member or members.
export data (Available)
    Export user data from a region to a filfor a checkinge.
export logs (Available)
    Export the log files for a member or members.
export offline-disk-store (Available)
    Export region data from an offline disk store into Geode snapshot files.
export stack-traces (Available)
    Export the stack trace for a member or members.
gc (Available)
    Force GC (Garbage Collection) on a member or members. The default is for garbage collection to occur on all caching members.
get (Available)
    Display an entry in a region. If using a region whose key and value classes have been set, then specifying --key-class and --value-class is unnecessary.
help (Available)
    Display syntax and usage information for all commands or list all available commands if <command> isn't specified.
hint (Available)
    Provide hints for a topic or list all available topics if "topic" isn't specified.
history (Available)
    Display or export previously executed GFSH commands.

import cluster-configuration (Available)                                                                                                                                                                      
    Imports configuration into cluster configuration hosted at the locators
import data (Available)
    Import user data from a file to a region.
list async-event-queues (Available)
    Display the Async Event Queues for all members.
list clients (Available)
    Display list of connected clients
list deployed (Available)
    Display a list of JARs that were deployed to members using the "deploy" command.
list disk-stores (Available)
    Display disk stores for all members.
list durable-cqs (Available)
    List durable client cqs associated with the specified durable client id.
list functions (Available)
    Display a list of registered functions. The default is to display functions for all members.
list gateways (Available)
    Display the Gateway Senders and Receivers for a member or members.
list indexes (Available)
    Display the list of indexes created for all members.
list jdbc-connections (Available)
    (Experimental) Display jdbc connections for all members.
list jdbc-mappings (Available)
    (Experimental) Display jdbc mappings for all members.
list lucene indexes (Available)
    Display the list of lucene indexes created for all members.
list members (Available)
    Display all or a subset of members.
list regions (Available)
    Display regions of a member or members.
load-balance gateway-sender (Available)
    Cause the Gateway Sender to close its current connections so that it reconnects to its remote receivers in a more balanced fashion.
locate entry (Available)
    Identifies the location, including host, member and region, of entries that have the specified key.
netstat (Available)                                                                                                                                                                                           
    Report network information and statistics via the "netstat" operating system command.                                                                                                                     
pause gateway-sender (Available)                                                                                                                                                                              
    Pause the Gateway Sender on a member or members.                                                                                                                                                          
pdx rename (Available)                                                                                                                                                                                        
    Renames PDX types in an offline disk store.                                                                                                                                                               
     Any pdx types that are renamed will be listed in the output.                                                                                                                                             
     If no renames are done or the disk-store is online then this command will fail.                                                                                                                          
put (Available)                                                                                                                                                                                               
    Add/Update an entry in a region. If using a region whose key and value classes have been set, then specifying --key-class and --value-class is unnecessary.                                               
query (Available)                                                                                                                                                                                             
    Run the specified OQL query as a single quoted string and display the results in one or more pages. Limit will default to the value stored in the "APP_FETCH_SIZE" variable. Page size will default to    
    the value stored in the "APP_COLLECTION_LIMIT" variable.                                                                                                                                                  
exit (Available)                                                                                                                                                                                              
    Exit GFSH and return control back to the calling process.                                                                                                                                                 
rebalance (Available)                                                                                                                                                                                         
    Rebalance partitioned regions. The default is for all partitioned regions to be rebalanced.                                                                                                               
remove (Available)                                                                                                                                                                                            
    Remove an entry from a region. If using a region whose key class has been set, then specifying --key-class is unnecessary.                                                                                
resume gateway-sender (Available)                                                                                                                                                                             
    Resume the Gateway Sender on a member or members.                                                                                                                                                         
revoke missing-disk-store (Available)                                                                                                                                                                         
    Instructs the member(s) of a distributed system to stop waiting for a disk store to be available. Only revoke a disk store if its files are lost as it will no longer be recoverable once revoking is     
    initiated. Use the "show missing-disk-store" command to get descriptions of missing disk stores.                                                                                                          
run (Available)                                                                                                                                                                                               
    Execute a set of GFSH commands. Commands that normally prompt for additional input will instead use default values.    

search lucene (Available)                                                                                                                                                                            [25/1681]
    Search lucene index                                                                                                                                                                                       
set variable (Available)                                                                                                                                                                                      
    Set GFSH variables that can be used by commands. For example: if variable "CACHE_SERVERS_GROUP" is set then to use it with "list members", use "list members --group=${CACHE_SERVERS_GROUP}". The "echo"  
    command can be used to know the value of a variable.                                                                                                                                                      
sh (Available)                                                                                                                                                                                                
    Allows execution of operating system (OS) commands. Use '&' to return to gfsh prompt immediately. NOTE: Commands which pass output to another shell command are not currently supported.                  
show dead-locks (Available)                                                                                                                                                                                   
    Display any deadlocks in the Geode distributed system.
show log (Available)
    Display the log for a member.
show metrics (Available)
    Display or export metrics for the entire distributed system, a member or a region.
show missing-disk-stores (Available)
    Display a summary of the disk stores that are currently missing from a distributed system.
show subscription-queue-size (Available)
    Shows the number of events in the subscription queue.  If a cq name is provided, counts the number of events in the subscription queue for the specified cq.
shutdown (Available)
    Stop all members.
sleep (Available)
    Delay for a specified amount of time in seconds - floating point values are allowed.
start gateway-receiver (Available)
    Start the Gateway Receiver on a member or members.
start gateway-sender (Available)
    Start the Gateway Sender on a member or members.
start jconsole (Available)
    Start the JDK's JConsole tool in a separate process. JConsole will be launched, but connecting to Geode must be done manually.
start jvisualvm (Available)
    Start the JDK's Java VisualVM (jvisualvm) tool in a separate process. Java VisualVM will be launched, but connecting to Geode must be done manually.
start locator (Available)
    Start a Locator.
start pulse (Available)
    Open a new window in the default Web browser with the URL for the Pulse application.
start server (Available)
    Start a Geode Cache Server.
start vsd (Available)
    Start VSD in a separate process.
status cluster-config-service (Available)
    Displays the status of cluster configuration service on all the locators with enable-cluster-configuration set to true.
status gateway-receiver (Available)
    Display the status of a Gateway Receiver.
status gateway-sender (Available)
    Display the status of a Gateway Sender.
status locator (Available)
    Display the status of a Locator. Possible statuses are: started, online, offline or not responding.
status server (Available)
    Display the status of a Geode Cache Server.
stop gateway-receiver (Available)
    Stop the Gateway Receiver on a member or members.
stop gateway-sender (Available)
    Stop the Gateway Sender on a member or members.
stop locator (Available)
    Stop a Locator.
stop server (Available)
    Stop a Geode Cache Server.
undeploy (Available)
    Undeploy JARs from a member or members.
upgrade offline-disk-store (Available)
    Upgrade an offline disk store. If the disk store is large, additional memory may need to be allocated to the process using the --J=-Xmx??? parameter.
validate offline-disk-store (Available)
    Scan the contents of a disk store to verify that it has no errors.
version (Available)
    Display product version information.



```
### Locator
The locator is a Geode process that tells new, connecting members where running members are located and provides load balancing for server use.

- Peer locator <--> members/cluster
Peer locators give joining members connection information to members alreadyrunning in the locator’s distributed system.

- Server locator <--> clients
Server locators give clients connection information to servers running in thelocator’s distributed system. Server locators also monitor server load and sendclients to the least-loaded servers.


By default, locators run as peer and server locators.


### Data Regions
region= table

### Data Entries
entries = row (instance of key/value)

### Cache



### Cluster Configuration Service
The Apache Geode cluster configuration service persists cluster configurations created by gfsh commands to the locators in a cluster and distributes the configurations to members of the cluster.



### chart structure
wordpress/
  Chart.yaml          # A YAML file containing information about the chart
  LICENSE             # OPTIONAL: A plain text file containing the license for the chart
  README.md           # OPTIONAL: A human-readable README file
  requirements.yaml   # OPTIONAL: A YAML file listing dependencies for the chart
  values.yaml         # The default configuration values for this chart
  charts/             # OPTIONAL: A directory containing any charts upon which this chart depends.
  templates/          # OPTIONAL: A directory of templates that, when combined with values,
                      # will generate valid Kubernetes manifest files.
  templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes


### Commands
connect --locator=172.17.0.3[10334]

create region --name=regionA --type=REPLICATE_PERSISTENT
start server --name=server1 --server-port=40411
start locator --name=locator1

put --region=regionA --key="1" --value="one"
query --query="select * from /regionA"

### MXBeans


### Q&A
- how many locator can I run? Are they redundant? 



### CUDB POC



Hello, 


    Find some info from CUDB wiki.


    1. The new CUDB architecture ( how they use Geode) 

        https://wiki.lmera.ericsson.se/wiki/CUDB_Prototype_team/CUDB_Renegade/Architecture


    2. Why they choose Geode, the database comparison

        You can also get the evaluation result from this page

        https://wiki.lmera.ericsson.se/wiki/CUDB_Prototype_team/CUDB_Renegade/DB_Comparison


    3. The CUDB Geode prototype (what do they care about, the detail use case)

        https://wiki.lmera.ericsson.se/wiki/CUDB_Prototype_team/Geode_Prototype


    4. Some CI/CD, testing meterials

        https://wiki.lmera.ericsson.se/wiki/CUDB_Prototype_team/CUDB_Renegade/CI_CD

        https://wiki.lmera.ericsson.se/wiki/CUDB_Prototype_team/CUDB_Renegade/Testing


## US verify 
1. Geode service can start/stop/restart successful
2. Geode client(Java/C++/Rest) can connect to geode cluster
3. support CURD and OQL
4. (optional) replication function works on different data centern
5. (optional) partition function works


### TC

kubectl run busybox -i -t --image=busybox --restart=Never -- sh

- TC1
```
kubectl run single-locator -i -t --image=armdocker.rnd.ericsson.se/sandbox/adp-staging/adp-gs/adp-gs-geode:0.0.1 --restart=Never -- bash
gfsh


create region --name=hello --type=REPLICATE
put --region=/hello --key=foo --value=bar
get --region=/hello --key=foo

query --query="select * from /hello"
```
- TC2
```
create region --name=regionA --type=REPLICATE_PERSISTENT
put --region=regionA --key="1" --value="one"
put --region=regionA --key="2" --value="two"
put --region=regionA --key="3" --value="three"
query --query="select * from /regionA"

```
- TC3
```
remove --key=2 --region=/regionA
query --query="select * from /regionA"
```


root@node-10-210-125-166:/home/elluffn# kubectl get po/dbservice-locator-0 -w
NAME                  READY     STATUS    RESTARTS   AGE
dbservice-locator-0   2/3       Running   0          11s

kubectl delete po dbservice-locator-0 

- TC99
```
show log --member=dbservice-locator-0
show metrics
```

kubectl delete po/single-locator

### Graceful shutdown

gfsh -e "connect" -e "stop locator --name $HOSTNAME"

 if [ $IS_LOCATOR == "true" ]; then

      gfsh -e 'connect --locator={{ .Values.dbservice.name }}-{{ .Values.dbservice.geode.locator.name }}[{{ include "choose-locator-port" . }}]' -e "stop locator --name $POD_NAME"

    else

      gfsh -e 'connect --locator={{ .Values.dbservice.name }}-{{ .Values.dbservice.geode.locator.name }}[{{ include "choose-locator-port" . }}]' -e "stop server --name $POD_NAME"

    fi 