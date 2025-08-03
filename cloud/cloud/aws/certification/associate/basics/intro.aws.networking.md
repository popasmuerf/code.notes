


## Regions, Availability Zones, and Local Zones 



- AWS Regions
- Avalablity Zones (AZs)
- Local Zones (LZs)


## AWS Regions 
- exist in separate geographic areas
- Each AWS Region comprises several independent and isolated data centers that
are called `Avalability Zones` (AZ) 
    * AZs that provide a full array of AWS services
- AWS data centers have a high level of redundancy
- Services available in AWS Regions
    * Direct Connect Gateway (DXGW)
    * Identity And Access Management (IAM)
    * Cloud Front 
    * Route53
    * Services will all eventually available globally, however
    that may or may not be the case for presently for certain 
    services and as such its always a good rule to configure all of your 
    services within the same Availability Zone unless there is a reason 
    to do otherwise...and provided that service is available globally at the time 
    of your design/implementation
        - RDS allows for fault tolerance across AZs so at least we are good
        there.
- AWS has dedicated Regions specifically and exclusively for the US government
called AWS GovCloud.
    * Allows for Federal agencies to run highly sensitive applications
    in this enviroment.
        - As AWS continues to grow...we can expect to see thes same specialized
        regions for other Governments (I wouldnt be suprised if the UK and Frend
        governments have their own AWS regions)
    * Offers the exact same services that you would find in any other region





## AWS AZs 
    - Components of AWS Regions
    - Are themselves composed of clusters of data centers within the region
    - A single AZ consists of multiple data centers 
    - These data centers are connected via dedicated fiber owned by AWS
    - data centers are located within 60 miles of each other
    - AZs have redundant/multiple power sources
    - AZs have a redundant connectivity and redundant resources
    - AZs within an AWS Region are interconnected. These connections have
    the following properties :
        * Fully redundant
        * High-Bandwidth
        * Scalable
        * Encrypted 
        * Dedicated

    - Multi-AZ deployment will automatically be assigned to the 
    service, but for some services, you may be able to designate which
    AZ is to be used.

## AWS LZs
    - LZs are the compute and storage infrastructure located close to 
    high-population areas and industrial centers and industrial
    centers, and offers high-bandwidth, low-latency connectivity
    to the broader AWS infrastructure.
    - Due to their promximity fo the customer, LZs facilitate the 
    delivery of applications that necessitate latency in single-digit
    milliseconds to end-users.
    - As o of March 2023, AWS had has 32 LZs 
    - AWS LZs can run various AWS services, 
        * EC2
        * VPC
        * EBS
        * ELB
        * FSx
        * EMR
        * ElastiCache
        * RDS

    in geographic proximity to your end users.


## Naming comvention for LZs is to use the AWS Region followed
by a location identifier, for example:

    us-west-2-lax-2a
    us-east-1a
    us-east-1b

    Region : us
    AZ : east-1a
    LZ : ??? I guess where ever there are 

# Benefits of the AWS Global Infrastructure

The following are the key benefits of using AWS's cloud
infrastructure

### Security 
### Availability
### Performance
### Scalability
### Flexibility






# AWS networkng foundations 


## Amazon Virtual Private Cloud (VPC)
    - One of the  core services provided by AWS
    - VPC'S are essentially a logically isolated and private network
    that can be subnetted via CIDR
    - VPCs are the sam as your ownlogical data center
    in a virtual setting inside the AWS cloud, where you have complete
    control over the resources inside your VPC.
    - AWS resources like AWS servers, and Amazon EC2 and Amazaon RDS
    instances are placed inside the VPC, includin gall the 
    required networking components to control the data traffc 
    as per your needs.
    -


### VPC concepts

    - CIDR 
    - Subnets
    - Route tables
    - Internet Gateway :
        * essentially the default gateway (router) of the VPC
        * IGW sits at the edge of the VPC and provides connectivity
        between the VPC and the public internet.  By default all VPC's
        are private and thus have no access to the internet.  You must specify if
        your VPC will be public and even then you must set ingress/egress rules
        via your VPC firewall, the Network Access Control List (NACL)
    - Network Acess Control Lists (NACL)
        * Network Control Lists is a fireqall that sits at the subnet boundary
        * Allows or denies incoming and outgoing packets
        * Is stateless
            - requires ingress rules
            - requires egress rules
    - Security Groups (SGs)
        * SGs are the virtual firewalls for your instances to control
        inbound and outbound packets.
        * Stateful
            - Ingress rules only
            - at the EC2 level
            - All traffic is blocked by default
            - Can filter traffic based on :
                * TCP
                * UDP
                * ICMP

    - VPC Flow Logs

    - Transit Gateway
        * Sort of like a virtual core switch for all of your VPC subnets
        * May be used to reduce the number of connections between your VPC subnets
        given the fact that all VPCs within your account by default can 
        communicate between each other.
        * Transit Gateways allow for you to create you own VPC subnet topology









    


