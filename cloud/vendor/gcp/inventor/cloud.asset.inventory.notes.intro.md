networking-lab-312020
adjunct-black



What resources are in (within this context) GCP
-------------------------------------
1. Domain and Org
2. Billing Account
3. Payments Profile
4. Projects, Folders


Common Resources Management Problems
------------------------------------------
1. Lost access(billing account, project, etc)
2. Confusion identifying invoices across Google services
3. Missed invoices
4. Inability to access Support
5. Delays in paying bill
6. Disruption of service




Domain
-------------------------------
1. manage the users of your org
2. control via google admin console(admin.google.com)


Organization
----------------------------------
1. Manage GCP resources and access (Root node in resource Hierarchy)
2. Control via GCP Console 
3. root node in gcp hierarchy


gcloud config get-value project # get current project id


gcloud asset search-all-resources \ 
    --scope <scope> \
    --query <query> \ 
    --asset-types <asset_types>
    --order-by <order-by>
    
### Scope : 
    May be any of these things:
        -   project:
            *   Allowed values:
                -   projects/<PROJECT_ID>
                -   projects/<project_number>
                -   folders/<folder_number>
                -   organizations/<organizations_number>
        -   folder
        -   organization
    Required permissions on target scope
        -   cloudasset.assets.searchAllResources 
    
     Allowed values:
        -   projects/<PROJECT_ID>
        -   projects/<project_number>
        -   folders/<folder_number>
        -   organizations/<organizations_number>   
        
    Example:
        gcloud asset search-all-resources \
        --scope adjunct-black
        
### Query : 
    Allows you to narrow or widen a search as needed:

    * name:Important to find Google Cloud resources whose name contains "Important" as a word.
    
    * name=Important to find the Google Cloud resource whose name is exactly "Important".
    
    * displayName:Impor* to find Google Cloud resources whose display name contains "Impor" as a prefix.
    * location:us-west* to find Google Cloud resources whose location contains both "us" and "west" as prefixes.
    
    * labels:prod to find Google Cloud resources whose labels contain "prod" as a key or value.
    
    * labels.env:prod to find Google Cloud resources that have a label "env" and its value is "prod".
    
    * labels.env:* to find Google Cloud resources that have a label "env".
    
    * kmsKey:key to find Google Cloud resources encrypted with a customer-managed encryption key whose name contains "key" as a word.
    
    * state:ACTIVE to find Google Cloud resources whose state contains "ACTIVE" as a word.
    NOT state:ACTIVE to find Google Cloud resources whose state doesn't contain "ACTIVE" as a word.
    
    * createTime<1609459200 or createTime<2021-01-01 or createTime<"2021-01-01T00:00:00" to find Google Cloud resources that were created before "2021-01-01 00:00:00 UTC". 1609459200 is the epoch timestamp of "2021-01-01 00:00:00 UTC" in seconds.
    
    * updateTime>1609459200 or updateTime>2021-01-01 or updateTime>"2021-01-01T00:00:00" to find Google Cloud resources that were updated after "2021-01-01 00:00:00 UTC". 1609459200 is the epoch timestamp of "2021-01-01 00:00:00 UTC" in seconds.
    
    * project:12345 to find Google Cloud resources that belong to a Google Cloud project with number 12345. Project id is not supported.
    
    * folders:(123 or 456) to find Google Cloud resources that are a descendant of Google Cloud folder with numbers 123 or 456.
    
    * organization:123 to find Google Cloud resources that are a descendant of Google Cloud organization with number 123.
    
    * parentFullResourceName:ImportantName to find Google Cloud resources whose parent's name contains ImportantName.
    
    * parentAssetType:Project to find Google Cloud resources whose parent's asset type contains Project.
    
    * Important to find Google Cloud resources that contain "Important" as a word in any of the searchable fields.
    
    * Impor* to find Google Cloud resources that contain "Impor" as a prefix in any of the searchable fields.
    
    * Important location:(us-west1 OR global) to find Google Cloud resources that contain "Important" as a word in any of the searchable fields and are also located in the "us-west1" region or the "global" location.

           
     gcloud asset search-all-resources \ 
    --scope <scope> \
    --query <query> \ 
    --asset-types <asset_types>
    --order-by <order-by>
    
### Assets Types : 
    A list of asset types to search.  If not specified or empty,
    it will search all the serchable asset types:
    
    Example:
        ```
        ichaelbrown172@cloudshell:~ (adjunct-black)$ gcloud asset search-all-resources \
        > --scope projects/adjunct-black \
        > --asset-types cloudresourcemanager.googleapis.com/Project,compute.googleapis.com/Instance
        ---
        additionalAttributes:
          networkInterfaces:
          - network: https://www.googleapis.com/compute/v1/projects/adjunct-black/global/networks/default
            networkIP: 10.150.0.19
        assetType: compute.googleapis.com/Instance
        createTime: '2021-05-17T15:13:48Z'
        displayName: adjunct-black-instance-1
        location: us-east4-c
        name: //compute.googleapis.com/projects/adjunct-black/zones/us-east4-c/instances/adjunct-black-instance-1
        networkTags:
        - http-server
        - https-server
        parentAssetType: cloudresourcemanager.googleapis.com/Project
        parentFullResourceName: //cloudresourcemanager.googleapis.com/projects/adjunct-black
        project: projects/434151827321
        state: TERMINATED
        ---
        additionalAttributes:
          projectId: adjunct-black
        assetType: cloudresourcemanager.googleapis.com/Project
        createTime: '2013-10-15T02:59:34Z'
        displayName: adjunct-black
        location: global
        name: //cloudresourcemanager.googleapis.com/projects/adjunct-black
        project: projects/434151827321
        state: ACTIVE
        michaelbrown172@cloudshell:~ (adjunct-black)$
        ```
             
     
 Example: "cloudresourcemanager.googleapis.com/Project,compute.googleapis.com/Instance" to search project and VM instance resources. Regular expressions are also supported. For example: "compute.googleapis.com.*" snapshots resources whose asset type starts with "compute.googleapis.com". See RE2 for all supported regular expression syntax. If the regular expression does not match any supported asset type, an INVALID_ARGUMENT error will be returned.
     
[searchable asset types](https://cloud.google.com/asset-inventory/docs/supported-asset-types#searchable_asset_types)
     
(Optional) ORDER_BY: A comma-separated list of fields specifying the sorting order of the results. The default order is ascending. Add " DESC" after the field name to indicate descending order. Redundant space characters are ignored. Example: "location DESC, name". Only string fields in the response are sortable, including name, displayName, description and location.     
     
     
     
     
### Asset discovery for IAM Polocies 

 gcloud asset search-all-iam-policies \
    --scope SCOPE \
    --query QUERY \
    
    
(Optional) SCOPE: A scope can be a project, a folder, or an organization. The search is limited to the Identity and Access Management (IAM) policies within this scope. The caller must be granted the cloudasset.assets.searchAllIamPolicies permission on the desired scope. If not specified, the configured project property will be used. To find the configured project, run: gcloud config get-value project. To change the setting, run: gcloud config set project PROJECT_ID.

The allowed values are:

    projects/PROJECT_ID (e.g., "projects/foo-bar")
    projects/PROJECT_NUMBER (e.g., "projects/12345678")
    folders/FOLDER_NUMBER (e.g., "folders/1234567")
    organizations/ORGANIZATION_NUMBER (e.g., "organizations/123456")

(Optional) QUERY: The query statement. See how to construct a query for more information. If not specified or empty, it will search all the IAM policies within the specified scope. Note that the query string is compared against each IAM policy binding, including its members, roles, and IAM conditions. The returned IAM policies will only contain the bindings that match your query. To learn more about the IAM policy structure, see IAM policy doc.

Examples:

    Examples:

    * policy:amy@gmail.com to find IAM policy bindings that specify user "amy@gmail.com".
    
    * policy:roles/compute.admin to find IAM policy bindings that specify the Compute Admin role.
    
    * policy:comp* to find IAM policy bindings that contain "comp" as a prefix of any word in the binding.
    
    * policy.role.permissions:storage.buckets.update to find IAM policy bindings that specify a role containing the "storage.buckets.update" permission. Note that if callers don't have iam.roles.get access to a role's included permissions, policy bindings that specify this role will be dropped from the search results.
    
    * policy.role.permissions:upd* to find IAM policy bindings that specify a role containing "upd" as a prefix of any word in the role permission. Note that if callers don't have iam.roles.get access to a role's included permissions, policy bindings that specify this role will be dropped from the search results.
    
    * resource:organizations/123456 to find IAM policy bindings that are set on "organizations/123456".
    
    * resource=//cloudresourcemanager.googleapis.com/projects/myproject to find IAM policy bindings that are set on the project named "myproject".
    
    * Important to find IAM policy bindings that contain "Important" as a word in any of the searchable fields (except for the included permissions).
     
    * resource:(instance1 OR instance2) policy:amy to find IAM policy bindings that are set on resources "instance1" or "instance2" and also specify user "amy".

    [Searching IAM policies](https://cloud.google.com/asset-inventory/docs/searching-iam-policies)
  
     
     
## Exporting an asset snapshot to Cloud Storage

To export all the asset metadata at a given timestamp to a Cloud Storage file, complete the following steps.
Note: The Cloud Storage bucket you use to store exported metadata must be in the project where Cloud Asset Inventory API is enabled and from which you're running the export.

    Create a new bucket if your project doesn't have an existing Cloud Storage bucket that is available to store exported data.

    To export asset metadata within your project, run the following command. This command stores the exported snapshot in a Cloud Storage bucket at gs://YOUR_BUCKET/NEW_FILE.

gcloud asset export \
   --content-type resource \
   --project PROJECT_ID \
   --snapshot-time SNAPSHOT_TIME \
   --output-path "gs://YOUR_BUCKET/NEW_FILE"

Where:

    PROJECT_ID: The ID of the project that is having its metadata exported. This project can be either the project where Cloud Asset Inventory API is enabled and from which you're running the export, or a different project.
    (Optional) SNAPSHOT_TIME: The value must be the current time or a time in the past at which you want to take a snapshot of your assets. By default, a snapshot is taken at the current time. See gcloud topic datetimes for information on time formats.

To export the assets of an organization or folder, you can use one of the following flags in place of the --project flag:

    --organization=ORGANIZATION_ID
    --folder=FOLDER_ID

(Optional) To check the status of the export, run the following command. It is displayed in the gcloud tool after running the export      
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
        
        
    
