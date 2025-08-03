


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

# Benefits of the AWS Global Infrastructure

The following are the key benefits of using AWS's cloud
infrastructure

### Security 
### Availability
### Performance
### Scalability
### Flexibility






Summary :

    Regions :
        US-West
        US-East



    


