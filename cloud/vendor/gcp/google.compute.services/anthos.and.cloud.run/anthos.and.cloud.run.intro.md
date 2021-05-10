#GKE - Cloud Run & Cloud Run for Anthos

##Quick recap...what are the primary choices for
##Computing in GCP ?
    - Compute Engine
    - App Engine
    - Google Function 
    - Google Kubernetes Engine
    - Google Cloud run
    - Goolge Anthos



##What is Google Cloud Run 
    - Fully managed
    - Allows for deployment of stateless containers
      without having to worry about underlying infrastructure
    - Workloads are automatically scaled out or in to zero depending
      on the traffic to your app.
    - You only pay when your app is running, billed to the nearest 
      100 milliseconds
      
##Cloud Run for Anthos
    - Abstracts away the complexity of Kubernetes
    - Allows for the "easy" leverage of Kubernetes and
      serverless together
    - It provides access to custom machine types, additional
      networking support and  Cloud Accelerators.
    - Allows you to run your workloads on-premises or on 
      on Google Cloud
    - Allows for Multi-cloud and on Prem deployment

## If you need a cluster but you aren't interested in the actual managment
## of these servers

### Cloud Run - "Container to Production in Seconds"
    - Build on top of an open standard - Knative
    - Fully managed serverless platform for containerized applications
        *   ZERO infrastructure management
        *   Pay-per-use(For used CPU, Memory, Requests and Networking)
        
### Fully integrated end-to-end developer experience 
    - No limitations in languages, binaries and dependencies
    - Easily portable because of container based architecture
    - Cloud Code, Cloud Build, Cloud Monitoring & Cloud Logging Integrations
    
### Anthos - Run Kubernetes clusters anywwhere
    - Cloud, Multi Cloud and On-Premise 










-Replicate master nodes across multiple zones for higher availability
-Remember that a portion of CPU cores on the nodes is reserved b Control Plane: 
    *   1st core 6%
    *   2nd core 1%
    *   3rd core .5%
    *   Nth core .25%
    
- Creating custome Docker Image for your microservices(Dokerfile):
    *   Build Image
        -   docker build -t in28min/hello-world-rest-api:0.0.1.RELEASE
    *   Test locally
        - docker run -d -p 8080:8080 in28min/hello-world-rest-api:0.0.Release
    *   Push it to Contianer Repository: 
        - docker push in28min/hello-world-rest-api:0.0.1.RELEASE
    
- Kubernetes supports Stateful deployments like Kafka, Redis, ZookKeeper
    *   StatefulSet - Seto of Pods with unique, presistent identities and 
        stable hostnames
        
- How do we run services on nodes for log collection or monitoring ?
    *   DaemonSet - One pod on every node!!!(for background services
    
- (Enabled by default) Integrates with Cloud Monnitoring and Cloud Logging
    *   Cloud Logging System and Application Logs can be exported to Big Query
        or Pub/Sub
    
    
# Google Kubernetes Engine Scenarios -1

###Scenario
You want to keep your costs low and optimize
your GKE implementation


###Solution
Consider 
    - Preembtible VMs
    - Appropiate region
    - Committed-use discounts
    - E2 machines types are cheaper than N1
    - Choose right enviroment to fit your owrkload type(like using multiple
      node pools if needed)
    
###Scenario
You want an efficient, completely auto scalign 
GKE solution


###Solution
Consider implimenting **Horizontal Pod Autoscaling**(HPA) 
for deployments and Cluster Autoscaler for node pools
    - Preembtible VMs
    - Appropiate region
    - Committed-use discounts
    - E2 machines types are cheaper than N1
    - Choose right enviroment to fit your owrkload type(like using multiple
      node pools if needed)
               
               
###Scenario
You want to execute untrusted, third-party code in Kubernetes
Clusters 


###Solution
Create a new node pool with GKE sandbox.  Deploy untrused code to 
the Sandbox node pool
    


               
###Scenario
You want to enable ONLY internal communication between your
microservice deployments in a Kubernetes Cluster


###Solution
Create Service of type ClusterIP


###Scenario
My pod stays pending(the pod basically isn't being deployed
to a node)


###Solution
Likely insufficient resources...you likely will need
to upgrade your node instances....or you may have to 
increase the number of nodes per pod...scaling out instead of 
scaling up as it were




###Scenario
My pod stays waiting(services deployed to but not running)


###Solution
Likely failure ot pull the image....
You might not be able to pull the image because
you don't have access rights....



    
    

- Pods are the smallest meta unit in Kubernetes...
- All containers are encapsulated within a pod
- Pods allow for the scaling of containers
- Pods allow for different versions of containers to be running in tandem...
- Pods make it easier to deploy, smoke test, etc new versions of deployments
  (being used along side replica sets
- Each pod has it's own IP address
- Failed pods are immidiately replaced
- Services are not the same thing as pods....
- Services expose your application(s) to the ouside world
- Services can be though of encapsulating your deployment
- Services provid for load balancing....so internal network issues will 
  be of no notice to your users
- Three types of Services
    * ClusterIP: Exposes service on a cluster-internal IP
    * LoadBalancer: Exposes Service to the internet....
    * NodePort: Exposes Service on each Node's IP at a static port(the NodePort)
    
  

<pre>

                                  ┌────────────┐
                   ┌──────────────┤ Deployment ├──────────────┐
                   │              │            │              │
                   │              └────────────┘              │
                   │                                          │
              ┌────▼──────┐                            ┌──────▼──────┐
    ┌───────┬─┤V1 Replica │                            │ V2 Replica  ├────────┐
    │       ├─┤   Set     │                            │    Set      │        │
    │       │ ├┬──────────┘                            └────────────┬┘        │
  ┌─▼──┐  ┌─▼─┴┤                                                    │         │
  │V1  │  │ v1 │                                                 ┌──▼──┐  ┌───▼─┐
  │Pod │  │ Pod│                                                 │ V2  │  │V2   │
  └─┬──┘  └───┬┘                                                 │ Pod │  │Pod  │
    │         │                                                  ├─────┤  ├─────┤
┌───▼────┐ ┌──▼────┐                                            ┌┴──▼──┴┐ ├──▼──┴┐
│  V1    │ │V1     │                                            │  V2   │ │V2    │
│  Cont- │ │Cont-  │                                            │  Cont-│ │Cont- │
│  ainer │ │ainer  │                                            │  ainer│ │ainer │
│        │ │       │                                            └───────┘ └──────┘
└────────┘ └───────┘


</pre>










##Create Service
> kubectl expose deployment name -type=<LoadBalancer | ClusterIp | > --port=80


## Geting a list of extant services
 > kubectl get services
```
NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
hello-world-rest-api   LoadBalancer   10.24.5.139   35.243.222.109   8080:32455/TCP   16h
kubernetes             ClusterIP      10.24.0.1     <none>           443/TCP          17h
```

## Deploy a new microservice which needs nodes with a GPU attached

    - Attach a new node pool with GPU instances to your cluster
        > gloud container node-pools create <POOL_NAME> --cluster <CLUSTER_NAME>
        > gloud container node-pools list --cluster <CLUSTER_NAME>
        
    - Deploy the new microservice to the new pool by setting up nodeSelector in the
      **deployment.yaml**
      
      * nodeSelector:cloud.google.com/gke-nodepool: <POOL_NAME>
      
    
## Delete the Microservices
    - Delete service
        > kubetcl delete service
        
    - Delete deployment
        > kubetcl delete deployment
        
## Delete the Cluster
    > gcloud container clusters delete
    
      
      
## Kubernetes - Deployment vs Replica Set
### A deployment is created for each microservice

    - A Deployment represents a microservice (with all it's releases)
    > kubectl create deployment m1 --image=m1:v1
    
### Deployment update with new image
    - Deployments manage new releases ensuring zero downtime

    > kubectl set image deployment hello-world-rest-api \
      hello-world-rest-api=in28min/hello-world-rest-api:0.0.2.RELEASE
      
```      
deployment.apps/hello-world-rest-api image updated
``` 
 

## Replica set ensures that a specific number of pods are running for a specfic microservice version
  
  
##  Display all replica sets
> kubectl get replicasets 
```
NAME                              DESIRED   CURRENT   READY   AGE
hello-world-rest-api-5df4778c79   10        10        10      27m
hello-world-rest-api-6d5479ddb6   0         0         0       17h
michaelbrown172@cloudshell:~ (networking-lab-312020)$
```

## Get list of pods
> kubectl get pods
```
NAME                                    READY   STATUS    RESTARTS   AGE
hello-world-rest-api-5df4778c79-9zdl6   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-kg2jl   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-lmsr9   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-mtbsn   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-n9h7k   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-qmxr9   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-srlf4   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-ssk8h   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-wldd5   1/1     Running   0          30m
hello-world-rest-api-5df4778c79-wzc9f   1/1     Running   0          30m
hello-world-rest-api-6d5479ddb6-42x29   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-4g26r   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-4vgt2   0/1     Evicted   0          15h
hello-world-rest-api-6d5479ddb6-5cj42   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-67td9   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-68pkx   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-76286   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-7vwt8   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-8hhbj   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-8qsvf   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-b2478   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-bkr4k   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dcmlz   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dq44p   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dtlmr   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-f468h   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-fcv27   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-gkxn5   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-h66sr   0/1     Evicted   0          15h
hello-world-rest-api-6d5479ddb6-hfj8m   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-l9jmq   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-ld8x9   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-lw8kn   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-m7qfc   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-mdqtx   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-mxg6j   0/1     Evicted   0          17h
hello-world-rest-api-6d5479ddb6-np9wd   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-nv26z   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-pm6pn   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-q4s54   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-qp9vk   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-r6hxk   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-rqvvz   0/1     Evicted   0          15h
hello-world-rest-api-6d5479ddb6-t4z99   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-tkdwm   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-v82dh   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-v8cd5   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-vk2v8   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-wbpck   0/1     Evicted   0          16h
```


##Scale deployment
> kubectl scale  deployment hello-world-rest-api --replicas=1
```
deployment.apps/hello-world-rest-api scaled
```

> kubectl get pods
```
NAME                                    READY   STATUS    RESTARTS   AGE
hello-world-rest-api-5df4778c79-ssk8h   1/1     Running   0          34m
hello-world-rest-api-6d5479ddb6-42x29   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-4g26r   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-4vgt2   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-5cj42   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-67td9   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-68pkx   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-76286   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-7vwt8   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-8hhbj   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-8qsvf   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-b2478   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-bkr4k   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dcmlz   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dq44p   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-dtlmr   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-f468h   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-fcv27   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-gkxn5   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-h66sr   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-hfj8m   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-l9jmq   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-ld8x9   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-lw8kn   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-m7qfc   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-mdqtx   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-mxg6j   0/1     Evicted   0          17h
hello-world-rest-api-6d5479ddb6-np9wd   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-nv26z   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-pm6pn   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-q4s54   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-qp9vk   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-r6hxk   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-rqvvz   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-t4z99   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-tkdwm   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-v82dh   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-v8cd5   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-vk2v8   0/1     Evicted   0          16h
hello-world-rest-api-6d5479ddb6-wbpck   0/1     Evicted   0          16h
```

> kubectl get replicasets
```
NAME                              DESIRED   CURRENT   READY   AGE
hello-world-rest-api-5df4778c79   1         1         1       36m
hello-world-rest-api-6d5479ddb6   0         0         0       17h
```
