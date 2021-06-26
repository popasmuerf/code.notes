(Managing Agent Policies)[https://cloud.google.com/logging/docs/agent/ops-agent/managing-agent-policies]



###   Agent Policies
1. enable automated installation and maintenance of Google
   Cloud's operations suite agents across a fleet of MVs that
   match user-specified criteria.
   
2. New policies cover both new and extent VMs, ensuring
   proper installationand optional auto-upgrade of all
   agents.
   
   
   
### Creating an Agent Policy
 
#### Best practices for using Agent Policies

To control the impact to production systems during rollout, it's
recommended to use instance labels and zones to filter
the the instances that the Policy applies to.


Example of a phasted rollout play for CentOS 7 VMs:

Phase 1: Create a policy to target all VMs with the label ``env=test``
and ``app=myproduct``

``
gcloud beta compute instances \
    ops-agents policies create ops-agents-policy-safe-rollout \
    --agent-rules="type=logging,version=current-major,package-state=installed,enable-autoupgrade=true;type=metrics,version=current-major,package-state=installed,enable-autoupgrade=true" \
    --os-types=short-name=centos,version=7 \
    --group-labels=env=test,app=myproduct
``
    
 
Update the policy to target ``env=test``
and ``app=myproduct`` and only a single zone 

``` 
gcloud beta compute instances \
    ops-agents policies update ops-agents-policy-safe-rollout \
    --group-labels=env=prod,app=myproduct \
    --zones=us-central1-c
```


Update that policy to clear the zones filter so it rolls out globally

```
gcloud beta compute instances \
    ops-agents policies update ops-agents-policy-safe-rollout \
    --clear-zones
```

