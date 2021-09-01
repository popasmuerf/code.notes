[Automation: Deploying an app in GKE using Ansible](https://faun.pub/automation-deploying-an-app-in-gke-using-ansible-4b6687967ac3)


Ansible infrastructure-as-code to
automate Nginx deployment in Google
Kubernetes Cluster(GKE) on Google
cloud Platform (GCP)

### Prerequisite

This tutorial is a continuation of my previous article called [How to automate the setup of a Kubernetes cluster on GCP](https://faun.pub/how-to-automate-the-setup-of-a-kubernetes-cluster-on-gcp-e97918bf41de). This article aimed to help you use Ansible¹ to create a Kubernetes Cluster in Google Cloud Platform (GCP)². Therefore, if you didn’t do it already, review the mentioned article before proceeding.

The code used to create this tutorial is available in this [repository](https://github.com/rafaelmnatali/k8s-gcp).

From this point on, I assume you already have an up and running GKE cluster.



#### Manage Kubernetes Objects with Ansible





<pre>
┌───────────────────────────────────────────────────────────────────┐
│                                                                   │
│       Kubernetes Cluster                                          │
│                                                                   │
│                                                                   │
│      ┌──────────────────────────────────────────────────┐         │
│      │                                                  │         │
│      │    NGINX NameSpace                               │         │
│      │                                                  │         │
│      │    ┌────────────────────────────────┐            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │     NGINX POD                  │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    │                                │            │         │
│      │    └────────────────────────────────┘            │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      │                                                  │         │
│      └──────────────────────────────────────────────────┘         │
│                                                                   │
│                                                                   │
│                                                                   │
│                                                                   │
└───────────────────────────────────────────────────────────────────┘
</pred>