[Kubernete4s cluster on GCP](source)

## Introl Using Ansible to isntall, setup, and configure a
Google Kubernetes Cluster(GKE) on Google Cloud Platform(GCP).


playbooks --------> Ansible --------->  GC{ |k85| }


### Automating the setup of a GKE cluster
As I briefly described in this [article](https://medium.com/marionete/building-a-serverless-ci-cd-pipeline-on-aws-12d1660ea384)

Infrastructure as Code (IaC) is paramount to maintain consistency across different enviroments.  IaC resolves
the enviroment drift issue where each enviroment has unique configurations that are not reproducible automatically.


The code used to create this tutorial is available in this [repository](https://github.com/rafaelmnatali/k8s-gcp).

Ansible Directilry layout :


<pre>
./
└── ansible                    # Ansible top-level folder
    ├── ansible.cfg            # Ansible config file
    ├── create-k8s.yml         # Ansible playbook to provision env
    ├── destroy-k8s.yml        # Ansible playbook to destroy env
    ├── inventory             
    │   └── gcp.yml            # Ansible inventory file
    └── roles
        ├── destroy_k8s        # Ansible role to remove k8s cluster        
        │   └── tasks
        │       └── main.yml
        ├── destroy_network    # Ansible role to remove VPC
        │   └── tasks
        │       └── main.yml
        ├── k8s                # Ansible role to create k8s cluster
        │   └── tasks
        │       └── main.yml
        └── network            # Ansible role to create VPC
            └── tasks
                └── main.yml
</pre>


#### Ansible Inventory
To begin with, create a yaml file in the ansible/inventory folder.  This ansible inventory  file
defines the variables that are going to be available for
our code.

Here is a sample inventory file:
```
    all:
    vars:
        # use this section to enter GCP related information
        zone: europe-west2-c
        region: europe-west2
        project_id: <gcp-project-id>
        gcloud_sa_path: "~/gcp-credentials/service-account.json"
        credentials_file: "{{ lookup('env','HOME') }}/{{ gcloud_sa_path }}"
        gcloud_service_account: service-account@project-id.iam.gserviceaccount.com

        # use the section below to enter k8s cluster related information
        cluster_name: <name for your k8s cluster>
        initial_node_count: 1
        disk_size_gb: 100
        disk_type: pd-ssd
        machine_type: n1-standard-2
```


#### Ansible Roles

After the inventory file, use Ansible roles to configure
the Ansible tasks to provision our cluster.  For this tutorial, I created two roles:

*   ansible/roles/network  
  - to provision a VPC

*   ansible/roles/k8s
  - to provision the K8 cluster

It is not manadatory to have a separate network for your cluster.  I created it because I didn't want to use the default network.

Below is the yaml configuration file for the network role:

```
    ---
    - name: create GCP network  
    google.cloud.gcp_compute_network:    
        name: network-{{ cluster_name }}    
        auto_create_subnetworks: 'true'    
        project: "{{ project_id }}"    
        auth_kind: serviceaccount    
        service_account_file: "{{ credentials_file }}"    
        state: present  
    register: network
```

The task above uses the plugin 
```
    google.cloud.gcp_compute_network
```
to created the VPC network.  The 
Jinja2 variables 
```
    {{}}
```

are replaced by the values entered int he
**iventory** file created early on.



the variable **network**, it's registered the output of this
task using the task keyword register.  The variable **network** is required during the cluster creation.


The next task is the one that provisions the Kubernetes cluster.  This taks uses two plugins: 

```
    google.cloud.gcp_container_cluster #1

    google.cloud.gcp_container_node_pool #2
```
1. Creates the Google Kubernetes Engine cluster
2. Creates node pools


Node pools are sets of nodes(vitual machines...and within this context Compute Engine instances) and
specifications under the contorl of the culster 
masters


Below is the **yaml** configuration file for the 8s role:

```
---
- name: create k8s cluster  
  google.cloud.gcp_container_cluster:    
    name: "{{ cluster_name }}"    
    initial_node_count: "{{ initial_node_count }}"    
    location: "{{ zone }}"    
    network: "{{ network.name }}"    
    project: "{{ project_id }}"    
    auth_kind: serviceaccount    
    service_account_file: "{{ credentials_file }}"    
    state: present  register: cluster - name: create k8s node pool  
  google.cloud.gcp_container_node_pool:    
    name: "node-pool-{{ cluster_name }}"    
    initial_node_count: "{{ initial_node_count }}"    
    cluster: "{{ cluster }}"    
    config:      
      disk_size_gb: "{{ disk_size_gb }}"      
      disk_type: "{{ disk_type }}"      
      machine_type: "{{ machine_type }}"    
    location: "{{ zone }}"    
    project: "{{ project_id }}"    
    auth_kind: serviceaccount    
    service_account_file: "{{ credentials_file }}"    
    state: present
```

### Ansible Playbook
The last step is to crate an Ansible playbook to execute
both roles.  In the **ansible** filder, I created a file called create-k8s.yml


```
---
    - name: create infra  
    hosts: localhost  
    gather_facts: false  
    environment:    
        GOOGLE_CREDENTIALS: "{{ credentials_file }}"roles:    
        - network    
        - k8s
```


Now, we can provision our Kubernetes cluster with the 
following command:

```
   ansible-playbook ansible/create-gke.yml -i ansible/inventory/<your-inventory-filename> 
```


**Output**

```
    PLAY [create infra] ****************************************************************

    TASK [network : create GCP network] ****************************************************************
    changed: [localhost]

    TASK [k8s : create k8s cluster] ****************************************************************
    changed: [localhost]

    TASK [k8s : create k8s node pool] ****************************************************************
    changed: [localhost]

    PLAY RECAP ****************************************************************
    localhost: ok=3  changed=3  unreachable=0  failed=0  skipped=0  rescued=0  ignored=0

```



#### Connecting to Kubernetes cluster
Use the **gcloud** command-line tool to connect  to the
Kubernetes cluster:


```
    gcloud container clusters get-credentials <cluster_name> --zone <zone> --project <project_id>
```


Note: replace the variables with the values used in the 
inventory file.  Also, it's possible to retrieve this command from the GCP console.


**Output**:
```
Fetching cluster endpoint and auth data.
kubeconfig entry generated for <project_id>.
```

**Using the Kubernetes cluster**

After connecting to th ecluster ust he **kubectl** command-line tool to control the cluster or the 
Google Cloud console.

```
    kubectl get nodes
    NAME                                       STATUS   ROLES    AGE   VERSION
    gke-<cluster_name>-node-pool-e058a106-zn2b Ready    <none>   10m   v1.18.12-gke.1210
```


#### Cleaning up

To delete the Kubernetes cluster, create a similar
structure with a playbook, rooles, and tasks.  
Basically, the only change required is that the
**state** in each task must be set to **absent**

Playbook file crated at **ansible/destroy-k8s.yml**:
``---
- name: destroy infra  
  hosts: localhost  
  gather_facts: false  
  environment:    
    GOOGLE_CREDENTIALS: "{{ credentials_file }}"       roles:    
  - destroy_k8s    
  - destroy_network

```


Configuring different roles and tasks for network and k8s enable us to destroy the Kubernetes and preserve the 
VPC, if we want to .

Roles and tasks crated at **ansible/roles**:

```
    ---
    - name: destroy GCP network  
    google.cloud.gcp_compute_network:    
        name: network-{{ cluster_name }}    
        auto_create_subnetworks: 'true'    
        project: "{{ project_id }}"    
        auth_kind: serviceaccount    
        service_account_file: "{{ credentials_file }}"    
        state: absent




**destroy_k8s/tasks:**

```
  - name: destroy k8s cluster  
    google.cloud.gcp_container_cluster:    
      name: "{{ cluster_name }}"    
      location: "{{ zone }}"    
      project: "{{ project_id }}"    
      auth_kind: serviceaccount    
      service_account_file: "{{ credentials_file }}"    
      state: absent
```






Execute the playbook to delete both **network** 
and **k8s** resources:


Output:

```
PLAY [destroy infra] ********************************************************************

TASK [destroy_k8s : destroy k8s cluster] ********************************************************************
changed: [localhost]

TASK [destroy_network : destroy GCP network] ********************************************************************
changed: [localhost]

PLAY RECAP ********************************************************************
localhost: ok=2   changed=2   unreachable=0   failed=0   skipped=0   rescued=0   ignored=0

```


### Conclusion
This tutorial has demonstrated how to use Infrastructure
as Code to install, setup, and configure a simple 
Kubernetes cluster on Google Cloud Platform.

Also shown is essential Ansible concepts like roles and 
playbook, and how to configure and structure them to 
provision and remove resources created in the cloud.

###  Ansible Directory Layout

<pre>

.
├── LICENSE                    # license file
├── README.md                  # main documentation file
└── ansible                    # Ansible top-level folder
    ├── ansible.cfg            # Ansible config file
    ├── create-k8s.yml         # Ansible playbook to provision env
    ├── deploy-app-k8s.yml     # Ansible playbook to deploy Nginx 
    ├── destroy-k8s.yml        # Ansible playbook to destroy env
    ├── undeploy-app-k8s.yml   # Ansible playbook to remove Nginx
    ├── inventory             
    │   └── gcp.yml            # Ansible inventory file
    └── roles
        ├── destroy_k8s        # Ansible role to remove k8s cluster        
        │   └── tasks
        │       └── main.yml
        ├── destroy_k8s_deployment # Ansible role to remove Nginx 
        │       └── tasks
        │           └── main.yml
        ├── destroy_network    # Ansible role to remove VPC
        │   └── tasks
        │       └── main.yml
        ├── k8s                # Ansible role to create k8s cluster
        │   └── tasks
        │       └── main.yml
        ├── k8s-deployment     # Ansible role to deploy Nginx
        │   ├── tasks
        │   │   └── main.yml
        │   └── vars
        │       └── main.yml
        └── network            # Ansible role to create VPC
            └── tasks
                └── main.yml

</pre>


### Ansible Roles

Create a new Ansible role on  **ansible/roles/k8s-deployment** with the following **main.yml** file under **tasks**.  this role will be responsible for creating the **namespace** and deploy the pod with Nginx 

### Ansible Roles

```
---
- name: Create a k8s namespace  
  kubernetes.core.k8s:    
    state: present    
    definition:      
      apiVersion: v1      
      kind: Namespace      
      metadata:        
        name: "{{ namespace }}" - name: Create k8s pod for nginx  
  kubernetes.core.k8s:    
    state: present    
    definition:      
      apiVersion: v1      
      kind: Pod      
      metadata:        
        name: "{{ app }}"        
        namespace: "{{ namespace }}"        
        labels:          
          app: "{{ app }}"      
      spec:        
        containers:          
          - name: "{{ app }}"            
            image: "{{ image }}"            
            imagePullPolicy: Always

```

### Ansible Inventory
In the Ansible Inventory file add a variable named **namespace**

```
...
# use the section below to enter k8s namespaces to manage
# this namespace is used in the Deploying an Application section
namespace: nginx
```



### Ansible Roles
Create a new Ansible role on **ansible/roles/k8s-deployment** with the following **main.yml** file under **tasks**.  This role will be
responsible for creating the **namespace** and deploy the **pod**
with **Nginx**

```
---
- name: Create a k8s namespace  
  kubernetes.core.k8s:    
    state: present    
    definition:      
      apiVersion: v1      
      kind: Namespace      
      metadata:        
        name: "{{ namespace }}" - name: Create k8s pod for nginx  
  kubernetes.core.k8s:    
    state: present    
    definition:      
      apiVersion: v1      
      kind: Pod      
      metadata:        
        name: "{{ app }}"        
        namespace: "{{ namespace }}"        
        labels:          
          app: "{{ app }}"      
      spec:        
        containers:          
          - name: "{{ app }}"            
            image: "{{ image }}"            
            imagePullPolicy: Always
```


We can group several actions within the same **task**.  In teh **task**
file above, it will first create the **Namespace** and then it will create the **Pod**.

Notice that the **kubernetes.core.k8s** plugin uses the standard kubernetes object **yaml** confguration to create the resources.

Investigating the role **directory structure**, we noticed that there is a **vars** folder.  We set variables in roles to ensure a value is used in the role and is not overridden by inventory variables.

Refer to Ansible Using Variables documentaiton for more details

Create a main.yml file under the
vars folser to set the Nginx variables.  We are using these values to replace **{{ app }}** 
and **{{ image }}** variables.

```
  ---
  app: nginx
  image: nginx:1.19.9-alpine
```

### Ansible Playbook

The last step is to create 
an Ansible playbook to execute the
**k8s-deployment** role.  In the 
