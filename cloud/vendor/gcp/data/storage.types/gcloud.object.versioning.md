## Object Versioning and Management


* Prevents accidental deletions and provides history
* Versioning can be turned off at any time
* The live version is the latest version
* Older versions are uniquely identified by (object key + generation number)
* Reduce costs by deleting older (noncurrent) versions
* Files are frequently accessed when they are created
  * Generally usage reduces with time
  * How do you save costs ?
  * Solution: Object Life-cycle Management
* Identify objects using conditions based on 
  * Age
  * Creation date
  * "IsLive"
  * Matching Storage classe
  * Number of extanct newer versions
* Two kinds of actions
  * SetStorageClass
    * Switching between classes
  * Deletion
    * Deleting objects

* Allowed Transistions:
  * Standard or Multi-Regional to Nearline
  * Nearline to (coldline or archive)
  * Coline to Archive


Cloud Storage Encryption
-   It's always encrypted server side
-   Default is to use Google managed key
-   You can use your own key
-  client side encryption is an option




| Scenario                                                                        | Solution                                                                                                |
|---------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| How do you speed up large uploads (example: 100 GB)                             | Parallel composite uploads                                                                              |
| You want to permantly store application logs for regulartory reasons            | Cloud storage -Archive                                                                                  |
| Log files stored in Cloud storage.  You expect to access them once in a quarter | Cold line                                                                                               |
| How do you change storage class of anexisting bucket in Cloud Storage           | 1. Change default storage  class of the bucket 2. Update the storage class of the objects in the bucket |
|                                                                                 |                                                                                                         |
|                                                                                 |                                                                                                         |
|                                                                                 |                                                                                                         |
|                                                                                 |                                                                                                         |
|                                                                                 |                                                                                                         |


# Security note:
-It is possible to edit the metadata of an object
