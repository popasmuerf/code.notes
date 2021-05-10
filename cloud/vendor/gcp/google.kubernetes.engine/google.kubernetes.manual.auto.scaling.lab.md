#Kubernetes - A Microservice Journey - Getting Started (Manual Scaling)
* Let's Have Some Fun: Let's get on a Journey with Kubernetes
1. Create a cluster
2. Deploy microservice
3. Do things.


# By default  a cluster intantiation will provide 1 cluster pod
# with 3 nodes...
# You may instantiate as many cluster pods as you like....
#
1. Create a Kubernetes cluster  with a default node pool
    > gcloud container clusters create #Or use the cloud console
    
    
2. Connect to cluster (this is the "hardware" cluster..which hosts the kubernetes cluster)
    > gcloud container clusters get-credentials foo-cluster-1 --zone us-east1-c --project networking-lab-312020
    
    
3. Connect to the Kubernetes cluster (The actual Kubernetes Cluster)
    > gcloud container clusters get-credentials foo-cluster-1 --zone us-east1-c --project networking-lab-312020
    
    
4. Creating a deployment 
    >kubectl create deployment hello-world-rest-api \
    --image=in28min/hello-world-rest-api:0.0.1.RELEASE  #This image is pulled from docker-hub


5. Deploy microservice to the cluster
   >kubectl get deployment
   
    NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
    hello-world-rest-api   1/1     1            1           11m
    
   > kubectl expose deployment hello-world-rest-api --type=LoadBalancer --port=8080 #need a LB for exposure to the outside world....may take a minute....
   
   > kubectl get service # checkout services status
        

    NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
    hello-world-rest-api   LoadBalancer   10.24.5.139   35.243.222.109   8080:32455/TCP   2m52s
    kubernetes             ClusterIP      10.24.0.1     <none>           443/TCP          56m
    
    > kubectl get services --watch #Check to see the real time status of you LB instance
        NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
        hello-world-rest-api   LoadBalancer   10.24.5.139   35.243.222.109   8080:32455/TCP   2m52s
        kubernetes             ClusterIP      10.24.0.1     <none>           443/TCP          56m
        michaelbrown172@cloudshell:~ (networking-lab-312020)$ kubectl get service --watch
        NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
        hello-world-rest-api   LoadBalancer   10.24.5.139   35.243.222.109   8080:32455/TCP   5m30s
        kubernetes             ClusterIP      10.24.0.1     <none>           443/TCP          58m
        
    > curl 35.243.222.109:8080  #verify
 
      {healthy:true}
      
    > curl 35.243.222.109:8080/hello-world
        
      Hello World  V1 mxg6j
    
    > kubectl get events  #Whats going on with my cluster ?
        LAST SEEN   TYPE     REASON                 OBJECT                                       MESSAGE
        40m         Normal   Scheduled              pod/hello-world-rest-api-6d5479ddb6-mxg6j    Successfully assigned default/
        hello-world-rest-api-6d5479ddb6-mxg6j to gke-foo-cluster-1-default-pool-d08a32c9-f85q
        40m         Normal   Pulling                pod/hello-world-rest-api-6d5479ddb6-mxg6j    Pulling image "in28min/hello-w
        orld-rest-api:0.0.1.RELEASE"
        40m         Normal   Pulled                 pod/hello-world-rest-api-6d5479ddb6-mxg6j    Successfully pulled image "in2
        8min/hello-world-rest-api:0.0.1.RELEASE"
        40m         Normal   Created                pod/hello-world-rest-api-6d5479ddb6-mxg6j    Created container hello-world-
        rest-api
        40m         Normal   Started                pod/hello-world-rest-api-6d5479ddb6-mxg6j    Started container hello-world-
        rest-api
        40m         Normal   SuccessfulCreate       replicaset/hello-world-rest-api-6d5479ddb6   Created pod: hello-world-rest-
        api-6d5479ddb6-mxg6j
        40m         Normal   ScalingReplicaSet      deployment/hello-world-rest-api              Scaled up replica set hello-wo
        rld-rest-api-6d5479ddb6 to 1
        27m         Normal   EnsuringLoadBalancer   service/hello-world-rest-api                 Ensuring load balancer
        27m         Normal   EnsuredLoadBalancer    service/hello-world-rest-api                 Ensured load balancer   
        
        
        
> kubectl get deploy
```
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
hello-world-rest-api   3/3     3            3           83m
```

> kubectl get pods
```
NAME                                    READY   STATUS    RESTARTS   AGE
hello-world-rest-api-6d5479ddb6-67td9   1/1     Running   0          17m
hello-world-rest-api-6d5479ddb6-7vwt8   1/1     Running   0          17m
hello-world-rest-api-6d5479ddb6-mxg6j   1/1     Running   0          85m
```      
        
## Scaling deployment
> kubectl scale deployment hello-world-rest-api  --replicas=3

> watch curl 


## Get some nodes for your cluster
> gcloud container clusters resize foo-cluster-1 \
  --node-pool \
  default-pool --num-nodes=5 \
  --zone=us-east1-c
  
```     
Pool [default-pool] for [foo-cluster-1] will be resized to 5.
Do you want to continue (Y/n)?  Y       
Resizing foo-cluster-1...done.
Updated [https://container.googleapis.com/v1/projects/networking-lab-312020/zones/us-east1-c/clusters/foo-cluster-1].
```   
   
> kubectl get deploy
```
NAME                   READY     UP-TO-DATE   AVAILABLE   AGE
hello-world-rest-api   100/100   100          100         100m
michaelbrown172@cloudshell:~ (networking-lab-312020)$
```
   
   
   
   
#Auto Scaling 
##7: Setup auto scaling for your microservice:
    > kubetcl autoscale deployment hello-world-rest-api --max=10 --cpu-percent=70 
      
   ```
   horizontalpodautoscaler.autoscaling/hello-world-rest-api autoscaled
   ```
   
  > kubectl get nodes
``
NAME                                           STATUS   ROLES    AGE    VERSION
gke-foo-cluster-1-default-pool-d08a32c9-f85q   Ready    <none>   150m   v1.18.17-gke.100
gke-foo-cluster-1-default-pool-d08a32c9-j1tv   Ready    <none>   11m    v1.18.17-gke.100
gke-foo-cluster-1-default-pool-d08a32c9-l33b   Ready    <none>   11m    v1.18.17-gke.100
gke-foo-cluster-1-default-pool-d08a32c9-nckr   Ready    <none>   150m   v1.18.17-gke.100
gke-foo-cluster-1-default-pool-d08a32c9-r59c   Ready    <none>   150m   v1.18.17-gke.100 
```

 > kubectl get hpa
 ```
NAME                   REFERENCE                         TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
hello-world-rest-api   Deployment/hello-world-rest-api   <unknown>/70%   1         10        10         2m9s 
```
   
   
##8: Setup auto scaling for your kubernetes cluster:   
   > gcloud container clusters update foo-cluster-1 --enable-autoscaling --min-nodes=1 --max-nodes=10
   
   
   
##9: Add some application configuration for your microservice via a **config-map**:   
   > kubectl create configmap todo-web-application-config \
   --from-literal=RDS_DB_NAME=todos 
```
configmap/todo-web-application-config created
```     

> kubectl get configmap
```
NAME                          DATA   AGE
hello-world-config            1      15s
kube-root-ca.crt              1      15h
todo-web-application-config   1      6m13s

```


> kubectl describe configmap
```
Name:         hello-world-config
Namespace:    default
Labels:       <none>
Annotations:  <none>
Data
====
RDS_DB_NAME:
----
todos
Events:  <none>
Name:         kube-root-ca.crt
Namespace:    default
Labels:       <none>
Annotations:  <none>
Data
====
ca.crt:
----
-----BEGIN CERTIFICATE-----
MIIDKzCCAhOgAwIBAgIRAJEGOLhOYtNnxNQRKuYFm2EwDQYJKoZIhvcNAQELBQAw
LzEtMCsGA1UEAxMkNDc0ZTA3YzgtM2VkOS00ZjY0LTgzMWUtMzY5NzAxMGUyNzFk
MB4XDTIxMDUwNjIzMjQ1OVoXDTI2MDUwNjAwMjQ1OVowLzEtMCsGA1UEAxMkNDc0
ZTA3YzgtM2VkOS00ZjY0LTgzMWUtMzY5NzAxMGUyNzFkMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw4fp7QlDKJuXR1XdplpHsGQXIzLTSzIOJoB5NCrh
rv7RRAvNJR//UgjdlG3O0Pnt5uofFvjm/pUElT1GFZveLMZ3wpu2nqnJCQXoB03m
oiCRs6aoj4R6AbxxCm2dDBXbtKfeV8j7z5/1IPl/T56JDN79xb1B4w3zcLeRw79p
tjTLIGKuSIVtnBcJoxws4/a8/zjuIfMPRLO6XMBazMT1iIy2Y4Vle5W1ZdgbM4Ep
OpCYdKgKOfntRGXJ+1opKEo1E0FICua8E2QwwkLk1yGoHmHttur9HuhtpyjHnshR
tSZmuwNOXfS2FTtUUPqAHMNi/QHIOnpIlRM4Q2siQ4EhZwIDAQABo0IwQDAOBgNV
HQ8BAf8EBAMCAgQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU62DVSF8B/l+W
jhxQJsFhn7mwB3swDQYJKoZIhvcNAQELBQADggEBAE9DG7+z4wXaEEsaiIqn2fx+
biB3ckWx+Ikk3heRxibGeqFfgyst0uTrgyp1IUOJdawzf2PHU6hqv+NipcY4QnLg
B34yh/Avkako60EUxW3az0FPMiOWb1XWsHGPxwxwqZOnsKzMlZaw6gPoNjy5+BHC
4CzkwyNTTt5ch0lYCzPmzh6NYIYwBAFz17FS3XnXyQpKZhtWTlkNSxqbtelFIh8j
ShhUJ7YX8zvMkzzs+81NDXCwJlZqAtogVnra1OWmiomZx3Oc1+0k1DwH72YXiL/B
rVd+91Dzipawh+/m5YeY+Jb9SSgVNbw+QjowOd4ZCXShOk2AZX4zJ/8IM4l87zM=
-----END CERTIFICATE-----
Events:  <none>
Name:         todo-web-application-config
Namespace:    default
Labels:       <none>
Annotations:  <none>
Data
====
RDS_DB_NAME:
----
todos
Events:  <none>
```




##10: Add password configuration for your microservice (store in Kubernetes as a **secret**)
   > kubectl create secret generic <secret-name> --from-literal=RDS_PASSWORD=<password>

> kubectl create secret generic hello-world-secrets-1 \
  --from-literal=RDS_PASSWORD=dummytodos
```  
secret/hello-world-secrets-1 created
```
> kubectl get secrets
```
NAME                    TYPE                                  DATA   AGE
default-token-sgbsb     kubernetes.io/service-account-token   3      15h
hello-world-secrets-1   Opaque                                1      58s
michaelbrown172@cloudshell:~ (networking-lab-312020)$
```

> kubectl describe secrets
```
Name:         default-token-sgbsb
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 01d32542-87a5-4f04-a025-67dca72c2eb4

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1159 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IldLTkRSVHEzM0F2QWZPdmY1YXpzRlFHR3dnQ0gwVzdqeDVVX25WaWJjWFUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tc2dic2IiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjAxZDMyNTQyLTg3YTUtNGYwNC1hMDI1LTY3ZGNhNzJjMmViNCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.pBml5g37KjjBm54VhJVlzhf3MIVBv-oxg30p190LHXNdurvCJxN8Z2SmAOMwWuBv6U34U2xsXnz8XkcZoHOpq2A_G9YkqikOBMdIrAtHEJnnhSYSmBl-sRKj_HObcYqw9bpKrp3ZZLtR5Y7QT4-PGHt9yilwR4ofka_isznqk0kaqa3KoSgP8R8SkLStKiRUqpFfoF_8X7ke72zqwpDsz38acbHq7qHtRn8YUKqg1szaV-QU_5R8cTD_ErUXhetSYAZvBABsyXEKgrGyrnIOD_ZJuXDnTpTmSrDfXDm1aJZZcIuxkzUDJSvh-zeI-AuTztij1js4qdo6d2ho33wB4w


Name:         hello-world-secrets-1
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
RDS_PASSWORD:  10 bytes
michaelbrown172@cloudshell:~ (networking-lab-312020)$
```





##Note about Kubernetes ConfigMaps :
A configmap is an API object that lets you store configuration for other objects touse.
Unlike most Kubernetes objects that have a *spec*, a configmap has **data** and **binaryData**
fields.  These fields accept key-value pairs as their values.  Both the data field and the 
binaryData fields are optional....  The data field is designed to contain UTF-8 byte sequence3s
while the binaryData field is designed to contain binary data as 
base64-enconded strings.

The name of a ConfigMap must be a valid DNS subdomain name.


   
           
###Alternative...use YAMl files to define deployment....

**Example**

```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2021-05-07T01:08:10Z"
  generation: 1
  labels:
    app: hello-world-rest-api
  managedFields:
  - apiVersion: apps/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:app: {}
      f:spec:
        f:progressDeadlineSeconds: {}
        f:replicas: {}
        f:revisionHistoryLimit: {}
        f:selector:
          f:matchLabels:
            .: {}
            f:app: {}
        f:strategy:
          f:rollingUpdate:
            .: {}
            f:maxSurge: {}
            f:maxUnavailable: {}
          f:type: {}
        f:template:
          f:metadata:
            f:labels:
              .: {}
              f:app: {}
          f:spec:
            f:containers:
              k:{"name":"hello-world-rest-api"}:
                .: {}
                f:image: {}
                f:imagePullPolicy: {}
                f:name: {}
                f:resources: {}
                f:terminationMessagePath: {}
                f:terminationMessagePolicy: {}
            f:dnsPolicy: {}
            f:restartPolicy: {}
            f:schedulerName: {}
            f:securityContext: {}
            f:terminationGracePeriodSeconds: {}
    manager: kubectl-create
    operation: Update
    time: "2021-05-07T01:08:10Z"
  - apiVersion: apps/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:deployment.kubernetes.io/revision: {}
      f:status:
        f:availableReplicas: {}
        f:conditions:
          .: {}
          k:{"type":"Available"}:
            .: {}
            f:lastTransitionTime: {}
            f:lastUpdateTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
          k:{"type":"Progressing"}:
            .: {}
            f:lastTransitionTime: {}
            f:lastUpdateTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
        f:observedGeneration: {}
        f:readyReplicas: {}
        f:replicas: {}
        f:updatedReplicas: {}
    manager: kube-controller-manager
    operation: Update
    time: "2021-05-07T01:08:17Z"
  name: hello-world-rest-api
  namespace: default
  resourceVersion: "15643"
  selfLink: /apis/apps/v1/namespaces/default/deployments/hello-world-rest-api
  uid: 4500e533-6fb4-4bd3-abe6-51f53e703d64
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: hello-world-rest-api
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hello-world-rest-api
    spec:
      containers:
      - image: in28min/hello-world-rest-api:0.0.1.RELEASE
        imagePullPolicy: IfNotPresent
        name: hello-world-rest-api
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2021-05-07T01:08:17Z"
    lastUpdateTime: "2021-05-07T01:08:17Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2021-05-07T01:08:10Z"
    lastUpdateTime: "2021-05-07T01:08:17Z"
    message: ReplicaSet "hello-world-rest-api-6d5479ddb6" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
  ```
  
  
 

