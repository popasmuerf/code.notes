## Cloud Storage (signed)

*   You need to grant a user limited time access to your objects, 
    *  User does not need a google account

*   Use Signed URLs
    *   A URL that gives permissions for limited time to perform specifc actions
    *   ACLs can be used to customized specific accesses to different objects

*  Create signed URL via Service Accounts


> gsutil signurl -d 10m <key> gs://<bucket-name/object-path>
