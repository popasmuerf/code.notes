#Kubernetes - A Microservice Journey - Getting Started
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

