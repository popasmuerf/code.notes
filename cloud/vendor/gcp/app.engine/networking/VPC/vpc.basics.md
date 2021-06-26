1. VPC's can allow for strictly internal networks and networks that are exposed to the outside world via load balancing or NAT
2. VPC's can have multiple subnets
3. VPC's are global and may be futher subdivided into regions.
4. Subnet's may exist in seperate regions
5. Private subnets will not be routed to the outside world.
6. Each subnet is associated with a specific region
7. Upon Subnet creation best practice is to enable **Private Google Access** to ensure that private IPs will be assigned unless there is a specific reason why this subnet should be public
8. Enable **FlowLogs** for security and trouble shooting purposes