#Security

**Security**  in cloud computing is a major concern.  Data in cloud should be stored in encrypted from accessing the shared data directly, proxy and brokerage
services should be employed.



#Security Planning

BEfore deploying a particular resource to cloud, one should need to analyze several aspects of the resource
such as:

-   Select resource that needs to move the cloud and analyze it's sensitivity to risk.
-   Consider cloud service models such as **IaaS**,**PaaS**, and **PaaS**.  These models require customer to be responsible for security at different levels of service.
-   Consider the cloud type to be use used such as **public**, **private**,**community**, **hybrid** .
-   Understand the cloud service provider's system about data storage and its transfer into and out of the cloud.


The risk of cloud deployment mainly depends upon the service models and cloud types.



##Understanding Security of Cloud
### Security Boundaries

A particular service model defines the boundary between
the responsibilities of service  provider and customer.  
**Cloud Sercurity Alliance  (CSA)** stack model defines the boundaries  between each service model and shows how different functional units relate to each other  The following diagram shows the CSA stack moeld




###Key Points to CSA Model

-   IaaS is the most basic level of service with PaaS and SaaS next two above levels of services.
-   Moving upwards, each of the service inherits capabilities and security concerns of the model beneath
-   IaaS provides the infastructure, PaaS provides the application run-time, and SaaS provides the application service.
-   IaaS has the least level of integrated functionalities and integrated security while SaaS has the most.
-   The model describes the security boundaries at which cloud service provider's responsibilities end and the customer's responsibilities begin.
-   Any security mechanism below the security boundary must be built  into th esystem and hyould be maintained by the customer


Although each service model has security mechanism, the security needs also depend upon where these services are located, in private, hybrid, or community cloud.



#Understanding Data Security
-   Access Control
-   Auditing
-   Authentication
-   Authorization

All of the service models should incorporate security mechanisms operating in all above-mentioned areas.


##Isolated Access to Data
Since data stored in the cloud can be accessed from anywhere, we must have a mechanism to isolate data and protect it from direct access by unauthorized individuals

**Brokered Cloud Storage Access**  is an approach for isolationg storage in the cloud.  In this approach, two services are created.

-   A broker with full access to storage but no access allowed directly by the client.
-   A proxy with no access to storage but access to both client and broker.



##Working with Brokered Cloud Storage Access System
When th eclient issues reuest to access data:
-   the data request goes to the external service interface of the proxy
-   the proxy fowards the request to the broker
-   the broker requsts the data from the cloud storage system
-   the cloud storage system return the data to the broker
-   the borker returns the data to the proxy
-  finally the proxy sends the data to the client









