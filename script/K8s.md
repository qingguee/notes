# K8s


## kubectl

  # Start a pod of busybox and keep it in the foreground, don't restart it if it exits.
  kubectl run -i -t busybox --image=busybox --restart=Never




kubectl delete po single-locator --force=false --grace-period=0

  kubectl run busybox -i -t --image=busybox --restart=Never -- sh
  / # nslookup dbservice-locator
  Server:    10.96.0.10
  Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

  Name:      dbservice-locator
  Address 1: 172.17.0.6 dbservice-locator-0.dbservice-locator.default.svc.cluster.local
  Address 2: 172.17.0.7 dbservice-locator-1.dbservice-locator.default.svc.cluster.local

### Service discover

https://fredjean.net/kubernetes-discovery/

- ENV
kubectl exec memcached-rm58b env | grep RABBITMQ
RABBITMQ_SERVICE_SERVICE_HOST=10.0.143.172
RABBITMQ_SERVICE_SERVICE_PORT_A=5672
RABBITMQ_SERVICE_PORT_5672_TCP_ADDR=10.0.143.172
RABBITMQ_SERVICE_PORT_15672_TCP_ADDR=10.0.143.172
RABBITMQ_SERVICE_PORT_15672_TCP_PORT=15672
RABBITMQ_SERVICE_PORT_15672_TCP=tcp://10.0.143.172:15672
RABBITMQ_SERVICE_PORT_5672_TCP_PORT=5672
RABBITMQ_SERVICE_SERVICE_PORT_B=15672
RABBITMQ_SERVICE_PORT_5672_TCP_PROTO=tcp
RABBITMQ_SERVICE_PORT=tcp://10.0.143.172:5672
RABBITMQ_SERVICE_PORT_5672_TCP=tcp://10.0.143.172:5672
RABBITMQ_SERVICE_PORT_15672_TCP_PROTO=tcp
RABBITMQ_SERVICE_SERVICE_PORT=5672

- DNS
https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
A records

“Normal” (not headless) Services are assigned a DNS A record for a name of the form my-svc.my-namespace.svc.cluster.local. This resolves to the cluster IP of the Service.

“Headless” (without a cluster IP) Services are also assigned a DNS A record for a name of the form my-svc.my-namespace.svc.cluster.local. Unlike normal Services, this resolves to the set of IPs of the pods selected by the Service. Clients are expected to consume the set or else use standard round-robin selection from the set.



### Affinity
- nodeSelector
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    disktype: ssd
```

- affinity
https://raw.githubusercontent.com/kubernetes/website/master/docs/concepts/configuration/pod-with-node-affinity.yaml


- inter-pod affinity/anti-affinity
https://raw.githubusercontent.com/kubernetes/website/master/docs/concepts/configuration/pod-with-pod-affinity.yaml

### API 1.9
https://v1-9.docs.kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/

### What is Ingress?
Typically, services and pods have IPs only routable by the cluster network. All traffic that ends up at an edge router is either dropped or forwarded elsewhere. 
Conceptually, this might look like:
```
    internet
        |
  ------------
  [ Services ]
```
An Ingress is a collection of rules that allow inbound connections to reach the cluster services.
```
    internet
        |
   [ Ingress ]
   --|-----|--
   [ Services ]

```
It can be configured to give services externally-reachable URLs, load balance traffic, terminate SSL, offer name based virtual hosting, and more. Users request ingress 
by POSTing the Ingress resource to the API server. An Ingress controller is responsible for fulfilling the Ingress, usually with a loadbalancer, though it may also 
configure your edge router or additional frontends to help handle the traffic in an HA manner.


### kubeadm


kubeadm init --pod-network-cidr=10.244.0.0/16 

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join --token b6c558.0037c3992772d716 146.11.23.2:6443 --discovery-token-ca-cert-hash sha256:081776d2a3e7843f21300176171598caaf58356d7932dd8b55afc7348c98abbb


kubeadm token create --print-join-command


#### kube-dns - Failed create pod sandbox
https://github.com/kubernetes/kubernetes/issues/56902
@00mfg Check the kubelet logs, if the problem is about portmap just download the 0.6 version of CNI (https://github.com/containernetworking/cni/releases) for your platform and put it to cni folder (/opt/cni/bin )


#### TE port

https://dl.k8s.io
https://k8s.gcr.io
https://gcr.io

gcr.io/google_containers/etcd-amd64                      3.1.11              59d36f27cceb        3 months ago        194MB
gcr.io/google-containers/kube-addon-manager              v6.5                d166ffa9201a        4 months ago        79.5MB
gcr.io/google_containers/kube-apiserver-amd64            v1.9.6              a5c066e8c9bf        4 days ago          212MB
gcr.io/google_containers/kube-controller-manager-amd64   v1.9.6              472b6fcfe871        4 days ago          139MB
gcr.io/google_containers/kube-proxy-amd64                v1.9.6              70e63dd90b80        4 days ago          109MB
gcr.io/google_containers/kube-scheduler-amd64            v1.9.6              25d7b2c6f653        4 days ago          62.9MB
gcr.io/google_containers/pause-amd64  


### namespace
kubectl create namespace elluffn
kubectl delete namespace elluffn

kubectl describe rc locator -n elluffn

kubectl --namespace=<insert-namespace-name-here> run nginx --image=nginx
kubectl --namespace=<insert-namespace-name-here> get pods

kubectl get pod -n elluffn

    metadata:
      labels:
        name: geode-server
        geode-server: "true"
        role: server
      namespace: elluffn

kubectl config set-context $(kubectl config current-context) --namespace=<insert-namespace-name-here>
# Validate it
kubectl config view | grep namespace:


### imagePullPolicy
spec:
  containers:
  - name: myapp
    image: myregistry.com/myapp:5c3dda6b
    ports:
    - containerPort: 80
    imagePullPolicy: Always

IfNotPresent 
Always
Never


## RC
kubectl create -f rc.yaml
kubectl describe rc frontend
kubectl replace -f rc.yaml
kubectl rolling-update frontend --image=kubeguide/guestbook-php-frontend:latest
kubectl rolling-update frontend -f FILE.yaml


kubectl describe rc -n elluffn


#### Scale Examples:                                                                                                    
  # Scale a replicaset named 'foo' to 3.                                               
  kubectl scale --replicas=3 rs/foo                                                    
  # Scale a resource identified by type and name specified in "foo.yaml" to 3.         
  kubectl scale --replicas=3 -f foo.yaml                                               
  # If the deployment named mysql's current size is 2, scale mysql to 3.               
  kubectl scale --current-replicas=2 --replicas=3 deployment/mysql   
  # Scale multiple replication controllers.                                            
  kubectl scale --replicas=5 rc/foo rc/bar rc/baz                                      
  # Scale job named 'cron' to 3.                                                       
  kubectl scale --replicas=3 job/cron


## StatefulSet
https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#Stable%20Network%20ID
Stable Network ID

- Pod Management Policies
In Kubernetes 1.7 and later, StatefulSet allows you to relax its ordering guarantees while preserving its uniqueness and identity guarantees via its .spec.podManagementPolicy field.

OrderedReady Pod Management
OrderedReady pod management is the default for StatefulSets. It implements the behavior described above.

Parallel Pod Management
Parallel pod management tells the StatefulSet controller to launch or terminate all Pods in parallel, and to not wait for Pods to become Running and Ready or completely terminated prior to launching or terminating another Pod.

### scale
kubectl scale statefulset/web --replicas=4



## Lables

Example labels:

"release" : "stable", "release" : "canary"
"environment" : "dev", "environment" : "qa", "environment" : "production"
"tier" : "frontend", "tier" : "backend", "tier" : "cache"
"partition" : "customerA", "partition" : "customerB"
"track" : "daily", "track" : "weekly"

## Trouble shotting
sudo journalctl -fu kubelet
sudo journalctl -fu docker.service


### Erikube
- Erikube Main page
https://openalm.lmera.ericsson.se/plugins/mediawiki/wiki/erikube/index.php?title=Main_Page


- vagrant
https://gerrit.ericsson.se/plugins/gitiles/erikube/erikube/+/master/docs/devs/vagrant-2-env.md
- deploy on PC
https://gerrit.ericsson.se/plugins/gitiles/erikube/erikube/+/master/development/local/README.md


### Helm issue with kubeadm

https://stackoverflow.com/questions/46672523/helm-list-cannot-list-configmaps-in-the-namespace-kube-system


kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade


### Minikube

minikube start minikube start --vm-driver kvm2 --docker-env http_proxy=http://www-proxy.lmera.ericsson.se:8080/ --docker-env https_proxy=https://www-proxy.lmera.ericsson.se:8080/


### Service

- Proxy-mode: userspace
serviceIP-> kube-proxy --> Pods

- Proxy-mode: iptables
kube-proxy--> serviceIP --> Pods

- Proxy-mode: ipvs
Kuber-proxy --> ServiceIP(Virtual Server) --> Pods

FEATURE STATE: Kubernetes v1.9
Similar to iptables, Ipvs is based on netfilter hook function, but uses hash table as the underlying data structure and works in the kernel space. That means ipvs redirects traffic much faster, and has much better performance when syncing proxy rules. Furthermore, ipvs provides more options for load balancing algorithm, such as:

rr: round-robin
lc: least connection
dh: destination hashing
sh: source hashing
sed: shortest expected delay
nq: never queue

#### Discovering services
https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
- Environment variables
For example, the Service "redis-master" which exposes TCP port 6379 and has been allocated cluster IP address 10.0.0.11 produces the following environment variables:
REDIS_MASTER_SERVICE_HOST=10.0.0.11
REDIS_MASTER_SERVICE_PORT=6379
REDIS_MASTER_PORT=tcp://10.0.0.11:6379
REDIS_MASTER_PORT_6379_TCP=tcp://10.0.0.11:6379
REDIS_MASTER_PORT_6379_TCP_PROTO=tcp
REDIS_MASTER_PORT_6379_TCP_PORT=6379
REDIS_MASTER_PORT_6379_TCP_ADDR=10.0.0.11
- DNS
For example, if you have a Service called "my-service" in Kubernetes Namespace "my-ns" a DNS record for "my-service.my-ns" is created. Pods which exist in the "my-ns" Namespace should be able to find it by simply doing a name lookup for "my-service". Pods which exist in other Namespaces must qualify the name as "my-service.my-ns". The result of these name lookups is the cluster IP.

Kubernetes also supports DNS SRV (service) records for named ports. If the "my-service.my-ns" Service has a port named "http" with protocol TCP, you can do a DNS SRV query for "_http._tcp.my-service.my-ns" to discover the port number for "http".

The Kubernetes DNS server is the only way to access services of type ExternalName. More information is available in the DNS Pods and Services.

#### Headless services
Headless services

Sometimes you don’t need or want load-balancing and a single service IP. In this case, you can create “headless” services by specifying "None" for the cluster IP (spec.clusterIP).

This option allows developers to reduce coupling to the Kubernetes system by allowing them freedom to do discovery their own way. Applications can still use a self-registration pattern and adapters for other discovery systems could easily be built upon this API.

For such Services, a cluster IP is not allocated, kube-proxy does not handle these services, and there is no load balancing or proxying done by the platform for them. How DNS is automatically configured depends on whether the service has selectors defined

#### Publishing services - service types
For some parts of your application (e.g. frontends) you may want to expose a Service onto an external (outside of your cluster) IP address.

Kubernetes ServiceTypes allow you to specify what kind of service you want. The default is ClusterIP.

Type values and their behaviors are:

- ClusterIP: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster. This is the default ServiceType.
- NodePort: Exposes the service on each Node’s IP at a static port (the NodePort). A ClusterIP service, to which the NodePort service will route, is automatically created. You’ll be able to contact the NodePort service, from outside the cluster, by requesting <NodeIP>:<NodePort>.
- LoadBalancer: Exposes the service externally using a cloud provider’s load balancer. NodePort and ClusterIP services, to which the external load balancer will route, are automatically created.
- ExternalName: Maps the service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up. This requires version 1.7 or higher of kube-dns.


## K8s healthy check
livenessProbe

readiness probes


## Volume 

### StorageClass
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/^C-default-class":"true"}}}'



### Set POD ENV examples

          securityContext:
            capabilities:
              add:
                - DAC_READ_SEARCH
                - SYS_RESOURCE
          args:
            - "-provisioner=example.com/nfs"
            - "-grace-period=10"
          env:
            - name: POD_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
            - name: SERVICE_NAME
              value: nfs-provisioner
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          imagePullPolicy: "IfNotPresent"
          volumeMounts:
            - name: export-volume
              mountPath: /export
      volumes:
        - name: export-volume
          hostPath:

### serviceAccount example
https://github.com/kubernetes-incubator/external-storage/blob/master/nfs/docs/authorization.md

kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  name: nfs-provisioner
spec:
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: nfs-provisioner
    spec:
      serviceAccount: nfs-provisioner
      containers:
        - name: nfs-provisioner
          image: quay.io/kubernetes_incubator/nfs-provisioner:v1.0.8
          ports:
            - name: nfs
              containerPort: 2049
            - name: mountd
              containerPort: 20048


10.210.125.166
https://wiki.lmera.ericsson.se/wiki/Upg/ADP_GS_GEODE#ADP_GS_GEODE


### Pod and Container Fields

Also, you can load pod and container fields that are available through Kubernetes API and set them as environment variables. Here is the list of available pod and container fields - replace <CONTAINER_NAME> with your conatiner name to get container fields:
```
spec:
  containers:
  - env:
    - name: MY_NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
    # Kubernetes 1.7+
    - name: MY_NODE_IP
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: MY_POD_NAME
      valueFrom:
        fieldRef:
          fieldPath: metadata.name
    - name: MY_POD_NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
    - name: MY_POD_IP
      valueFrom:
        fieldRef:
          fieldPath: status.podIP
    - name: MY_POD_SERVICE_ACCOUNT
      valueFrom:
        fieldRef:
          fieldPath: spec.serviceAccountName
    # Kubernetes 1.8+
    - name: MY_POD_UID
      valueFrom:
        fieldRef:
          fieldPath: metadata.uid
    - name: MY_CPU_REQUEST
      valueFrom:
        resourceFieldRef:
          containerName: <CONTAINER_NAME>
          resource: requests.cpu
    - name: MY_CPU_LIMIT
      valueFrom:
        resourceFieldRef:
          containerName: <CONTAINER_NAME>
          resource: limits.cpu
    - name: MY_MEM_REQUEST
      valueFrom:
        resourceFieldRef:
          containerName: <CONTAINER_NAME>
          resource: requests.memory
    - name: MY_MEM_LIMIT
      valueFrom:
        resourceFieldRef:
          containerName: <CONTAINER_NAME>
          resource: limits.memory
```