
NOTE: 
The main difference between SaaS and PaaS is that SaaS describes services
that are 100% managed by the Vendor.  PaaS is a superset of SaaS but requires user management 
and maintenance....basically your custom software and Data.  What we had at LOC was definitely PaaS
PaaS differs from SaaS as in that AWS provides the platform(provisioning, etc), but you have to provide the software
and data.


## IaaS
- virtualiztion
- servers
- storage
- networking
- advantages
    * Flexibility
    * Ease of Provisioning
    * Resources are as ephemeral as need be
    * Complete control of infrastructure
    * Fault tolerance and scalable at awill
    * granular controle (to a degree)
- disadvantages 
    - Security
    - Vendor lockin
    - encryption 
    - little support for legacy systems 
    - training costs 
- Use cases 
    * analytics
    * disaster recovery
    * web hosting 
    * software engineering enviroments
- Examples of AWS IaaS services
    * EC2
    * EBS
    * SAN
    * EFS



## PaaS
- virtualization
- servers
- storage
- networking
- runtime
- middleware
- operating system

- advantages
    * You have granualar and complete control over the software and data
    * Cheaper than going with SaaS
    * High Availability and scalability than on-prem
    * Reduction of LOE in maintaning infrastructure
    * Easier to maintain security policy

- disadvantages 
    * You are pretty much on your own with respect to application maintenance
    * You are pretty much on your own with respect to security
    * You are pretty much on your own with respect to data...this includes PII issues.
    * Your specific runtimes may not be supported by AWS.  for instance...AWS does not support Rust, or D.  
    Support for Go is limited.  Old EOL versions of industry standard runtimes like Java or C# may not be supported
    * Legacy system customization
    * Operational limitations....even though you pretty have full control of your applications and data....what you can achieve 
    with either may be limited by the platform

- Use cases 
    * Data Analytics
    * IoT
    * Business Analytics/Intelligence (BI)
    * Business Process Management (BPM)
    * Databases 
    * API management/development
    * Master Data Management(MDM)

- Examples of AWS PaaS services
    * Elastich BeanStalk
    * Amazon RDS
    * AWS Lambda (FaaS)
    * Amazon Elastic Kubernetes Service 


- Examples of 3rd-Paty PaaS solutions
    * RDS
    * Lambda
    * Glue
    * Kinesis
    * AWS' entire data engineering infrastructure


## SaaS
- virtualization
- servers
- storage
- networking 
- runtime
- middleware
- operating system
- data
- Application 

- advantages
    * Reduces time, money, and effort spent on repetative tasks
    * Managed by Vendor

- disadvantages 
    - Often complex interoperabiility w/r to integration with other services and on prem resources
    - Managed by vendor so customization is often an issue
    - Lack of control which often conflicts with regulartory policies
    - Limite features 
- Use cases 
    * Payroll services like ADP
    * CRM such as Salesforce
    * collaboration solutions like Zoom, Webex, Teams, 365, etc
    * Workspace solutions, like Amazon WorkSpaces, Google Worksspace, Microsfot Workspace 
- Examples of AWS SaaS services
    * Amazon Connect
    * Amazon Workspaces
    * Amazon QuickSight 
    * Amazon Chime

- Examples of 3rd-Paty SaaS solutions
    * Splunk
    * Sendbird 
    * Wilio



