

## Service Accounts use case Scenario Cloud Storage

1. Create a Service Account Role with the right permissions.
2. Assign Sercie Account role to VM instance
3. Uses Coogle Cloud-managed keys:
    -   Key generation and use are automatically handled by IAM when we assign a service account to the instance
    -   Automatically rotated
    -   No need to store credentials in config files


4. Do NOT delete service accounts used by running instances:
    -   Applications running on those instances will lose access!



## Use case 2: On Prem <-> Cloud Storage (Long Lived)
* You CANNOT assign Service Account directly to an On Prem App
1. Create a Service Account Role with the right permissions.
2. Create a Service Account User Managed Key
    -   gcloud iam service-accounts keys create
    -   Download the service account key file
        *    Keep it secure(it can be used to impersonate service account!!!)   
3. Make the service account key file accessible to your applicaiton
        *   Set enviroment variable GOOGLE_APPLICATION_CREDENTIALS
        *   export GOOGLE_APPLICATION_CREDENTIALS="/PATH_TO_KEY_FILE" 
4. Uses Google Cloud client libraries:
    -   Google Cloud client Libraries use a library - Application Default Credentials(ADC)


## Use case 3: On Prem <-> Google Cloud APIs (Short Lived)
* Make calls from outside the GCP to Google Cloud APIs with short lived permissions
  * Few hours or less
  * Less risky compared to sharing service account keys!
1. Credential Types.
    *   OAuth 2.0 access tokens
    *   OpenID Connect ID tokens
    *   Self-signed JSON Web Tokens(JWTs)

2. Examples:
    *   When a member needs elevated permissions, he can assume the service account role(Create OAuth 2.0 access token for service account)
    *   OpenID Connect ID tokens is recommened for service to service authentications:
        *   A service in GCP needs to authenticate itself to a service in other another cloud


## Service Account Scenarios

| Scenario                                                                                                | Solution                                                                                                                                                |
|---------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Application on a VM wants to talk to a Cloud Storage                                                    | Configure the VM to use Service Account with right permissions                                                                                          |
| Application on a VM wants to put a message on a Pub Sub Topic                                           | Cloud storage -Archive                                                                                                                                  |
| Is Service Account an indentity or a resource                                                           | It is both.  You can attach roles with Service Accounts.  You can let other members access a SA by granting them a role on the Service Account(resource |
| VM instance with default service account in Project A needs to access Cloud storage bucket in Project B | In Project B, add the service account from Project A and assign Storage Object Viewer Permission on the bucket                                          |
|                                                                                                         |                                                                                                                                                         |
|                                                                                                         |                                                                                                                                                         |
|                                                                                                         |                                                                                                                                                         |
|                                                                                                         |                                                                                                                                                         |
|                                                                                                         |                                                                                                                                                         |

