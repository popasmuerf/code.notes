[source](https://cloud.google.com/sdk/docs/install#deb)


| Feature                                       | Standard                  | Balanced                             | SSD               |
|-----------------------------------------------|---------------------------|--------------------------------------|-------------------|
| Underlying Storage                            | Hard Disk Drive           | Solid State Drive                    | Solid State Drive |
| Referred to as                                | pd-standard               | pd-balanced                          | pd-ssd            |
| Peformance -Sequential IOPS(Big Data/Batch    | Good                      | Good                                 | Very Good         |
| Performance - Random IOPS(Transactional Apps) | Bad                       | Good                                 | Very Good         |
| Cost                                          | Cheapest                  | Middling                             | Expensive         |
| Use cases                                     | Big Data (cost efficient) | Balance between cost and performance | High performance  |
|                                               |                           |                                      |                   |
|                                               |                           |                                      |                   |
|                                               |                           |                                      |                   |
|                                               |                           |                                      |                   |





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
 
 
 
 
 #Persistent Disks - Snapshots - Recommendations
 
*   Avoid taking snapshots more often than once an hour
*   Disk volume is available for use **but Snpashots reduce peformance**
    -   (Recommended) Schedule snapshots during off-peak hours
*   Creating snapshots from disk is faster than creating from images:
    -   But creating disks from image is faster than creating from snapshots
    -   (RECOMMENDED) if you are repeatedly creating disks from a snapshot
        *   Create an image from snapshot andust he image to create disks
*   Snapshots are incremental:
    -   BUT  you don't lose data by deleting older snapshots
 
*   VM instance disks can be configured to
    - Delete along with VM when deleting a VM(default)
    - Persist after it's associated VM is deleted
 
*   Snapshots along with disks can be 
    -   Regional
    -   Multi-regional
    
*   Subsequent snapshots of a disk only contain the differences between
    the snapshots.  This is why it takes longer to re-create and VM image
    from snapshots than it does from a straight image backup.
 
 
*   Snapshots can be automated via creating snapshot schedules
*   Snapshot retention policies should  be adhered to for your organization
    but understand they take up storage and thus cost money. 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  

    



