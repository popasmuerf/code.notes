## Cloud Storage (Access Control Lists)

*   ACL 
    *  Define who has access to your buckets and objects, as well as what level of access they have

*   How is this different from IAM ?
    *   IAM permissions apply to all objects within a bucket
    *   ACLs can be used to customized specific accesses to different objects

*   User gets access if he is allowed by either IAM or ACL!
*   (Remember) Use IAM for common permissions to all objects
*   (Remember) Use ACLs if you need to customize access to individual objects
