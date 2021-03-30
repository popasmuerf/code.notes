[Source url <--click here ](https://go.netskope.com/rs/665-KFP-612/images/NS-Top-10-AWS-Security-Mistakes-WP-00-4.pdf)

1. Cloud vendors are responsible for security of the cloud.
2. Customers are responsible for seucrity in the cloud



#Top 10 Security issues w/r to operating withing the cloud.

1. Using the root accoutn for everyday activity
   - Self explanitory
   
2. Failing to partition user and role permissions
   - Roles should be authorized to accomplish only the tasks they are assigned
   - Grant additional permissions only when needed and then remove them when no longer required.
   - Permissions should be granular

3. Granting Global Access to S3 buckets
   -    S3 buckets are public cloud storage
   -    S3 buckets often contain sensistive information like billing information.
   -    S3 bucket names are globablly unique, thus it is easy to find and identify target S3 buckets by nefarious actors.
   -    Access Control for files and folders may be different from bucket level policies.
   -    Third party tools exist to mitigate these issues

4. Failure to use multi-factor authentication
   -    Many data breaches occur due to poor password complexity enforcement.
   -    In the modern era, single sign on isn't a sufficient security mechanism to keep data safe.
   -    Multifactor Authentication(MFA) is a "must" these days.
   -    Examples of MFA
        *   **One Time Passwords (OTP)** via phone or  email to the user to verify their identity before completeing their login
        *   USB hardware tokens: Attaching a USB that generates an OTP to authenticate the user before allowing access.
        *   Tools that are easy to use for MFA without adding another layer of complexity is Google Authenticator.

5.  Failing to Encrypt Data-at-Rest
    -    Providers like AWS, IBM, et al provide key-management servicies that let you manage encryuption keys.
    -    Users should  employ these services to encrypt data-at-rest, but do not for a variety of reasons.
    -    Encryption best practices
        *    Specifying encryption keys
        *    Who are are allowed to use encryption keys
        *    Locking down encryption keys
    -    Encryption does not prevent breaches, but they do ensure that dhttps://go.netskope.com/rs/665-KFP-612/images/NS-Top-10-AWS-Security-Mistakes-WP-00-4.pdfk ACLs
   -    Port scans and probes are a frequently used attack vector to w/r to  the weakest links for infiltrating  networks.
   -    Firewalls need to be implemented at all three levels:
        *    IaaS
        *    PaaS
        *    SaaS
   -    Network ACLs at all three levels become more granular from IaaS ---> SaaS and as such block much "noise" the hire you go up the service stack...
   -    Make use of specific netowork ACLs to limit traffic and reduce noise.  For example, only allow SSH to originate from a certain IP block within the ACLs, you will not recieve block notifications in the VPC flow logs from the instances themselves.  Compromised credentials cannot be used from IP addresses no on the ACL white-list.  SSH scanning will not hit any of your service components that are not IP white-listed.

7. Failure to use monitoring and logging services
   -    Providers posess a number of ways to help users manage, understand, and fine-tune their cloud services for increased security and all-around better operation, and the more you can learn about these methods, th ebetter.  New or non-expert users in particular should stronglyu consider using the following:
   -    **AWS Config**
   -    **CloudWatch**
   -    **CloudTrail**


8. Failing to notice anomalous activity or act on it.
   -    Every change noticed in your cloud enviroment should be noticed and questioned.
   -    Make daily use of logs and data
   -    Use ACLs to reduce the noise to signal ratio in order to make anomalous activity in your enviroment more obvious.
   -    Be aware of the general config of your enviroment...for example know by heart the subnets used and for what purpose, know the domain names used in your enviroment and for what purposes are they used for...etc


9. Failing to regularly change security credentials (access keys) regularly
    -    Self explanitory.
    -    Set expiration dates for all security credentials
    -    Vendor provided credentials will have a default expiration date
    -    Ensure that any applications under development do not use hardcoded credentials in any enviroment outside of DEV
    -        