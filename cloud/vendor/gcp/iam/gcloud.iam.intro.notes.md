# Cloud IAM Example

*   I want to provide access to manage a specific cloud storage bucket to a colleague of mine:
    *   Important Generic Concepts:
        *   Member
            *   My colleague
        *   Resource
            *   Specific cloud storage bucket
        *   Action
            *   Upload/Delete Objects

*  In Google cloud IAM
    *   Roles:
        *   A set of permissions (to peform specific actions on specific resources)
            *   Roles do not know about members 
        *   How do you assign permissions to a member ?


 1: Choose a Role with the corect permissions(Ex: Storage Object Admin)

 2: Create Policy binding member with role(permisissions)

 ** IAM in AWS is very different from GCP...there really
    isn't a straight analog for the two.

## IAM - Roles
1. Roles are Permissions
   1. Perform some set of actions
2. Three Types
   1. Basic Roles(Should not be used in Prod)
      1. Viewer(roles.viewer) - Read Only
      2. Editor(roles.editor) - Manage Roles, permissions, billing
    2. Predefined Roles 
       1. Storage Admin
       2. Storage Object Admin
       3. Storage Object Viewer
       4. Storage Object Creator
    3. Custom Roles (When Pre-Defined roles aren't going to cut it)
       1. 


