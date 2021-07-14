## Transit gateway attachments to a VPC
[source](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html)

When you attach a VPC to a transit gateway you must
specify one subnet from each Availability Zone to be used
by the transit gateway to route traffic.  Specify one
subnet from an Availability Zone enables traffic to 
reach resources in every subnet in that Availability
zone.



## Limits

When you attach a VPC to a transit gateway, any resources
in Availibility Zones where there is no transit gatway
attachment cannot reach the transit gateway.

If there is a route to the transit gatway in a subnet 
route table,  traffic is forwarded to the 
transit gatway only when the tyransit gateway 
has an attachemnt in 