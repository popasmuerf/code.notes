[source](https://cloud.google.com/sdk/docs/install#deb)


# Playing with disks - Command Line

  > gcloud compute disks list [create | delete | resize | snapshot ]
  >#Example
  > gcloud create foo-disk-1 --zone=us-east1-a


  > gcloud compute disks list [create | delete | resize | snapshot ]
  >#Example
  > gcloud create foo-disk-1 --zone=us-east1-a

  > gcloud compute disks list [create | delete | resize | snapshot ]
  >#Example
  > gcloud create foo-disk-1 --zone=us-east1-a




#Persistent Disks - Snapshots
*   Take **point-in-time snapshots** of your Persistent Disks
*   You can also schedule snapshots (configure a schedule): 
*   Snapshots can be Mulit-regional and Regional
*   You can create new disks and instance from snapshots
*   Snapshots are incremental:
    -   Deleting a snapshot only **deletes data which which is NOT needed by other snapshots**
*   It's best practice to write data to a seperate disk from the the VM's primary disk(that also houses
    your OS)
    -   It makes it easier to organize your data
 
 
 
 
 # Playing with Machine Images
 
 ## What is a a Machine Image ?
 
 A machine image is a Compute Engine resource that stores all the configuration, metadata, permissions, and data from one or more disks required to create a virtual machine (VM) instance. You can use a machine image in many system maintenance scenarios, such as instance creation, backup and recovery, and instance cloning.
 
*   (Remember) **Machine Image** is differnet from VM images
*   **Multiple disks can be attached with a VM**
    -   One Book Disk(Your OS, etc)
    -   Multiple Data disks
*   An image is created from the boot Presistent Disk
*   HOWEVER, a Machine Image is created froma  VM instance:
    -   Machine Images contain everything you need to create a VM instance:
        *   Configuration
        *   Metadata
        *   Persmissions
        *   Data from one or more disks
 
*   Recommended for disk backups, instance cloning and replication
 

## When to use a machine


| Scenarios                        | Machine Image | Persistent disk snapshot | Custom image | Instance template |
|----------------------------------|---------------|--------------------------|--------------|-------------------|
| Single disk backup               | Yes           | Yes                      | Yes          | No                |
| Multiple disk backup             | Yes           | No                       | No           | No                |
| Differential backup              | Yes           | Yes                      | No           | No                |
| Instance cloning and replication | Yes           | No                       | Yes          | Yes               |
| VM instance configuration        | Yes           | No                       | No           | Yes               |

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  

    



