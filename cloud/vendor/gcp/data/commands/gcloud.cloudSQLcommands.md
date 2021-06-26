## gcloud sql
gcloud sql instances <create | clone | delete | describe | patch >
    > gcloud sql create <instance>
    > gcloud sql instances patch --backup-start-time


gcloud sql databases <create  | delete | describe | list | patch >
    > gcloud sql databases create <database> --instance=INSTANCE
    > gcloud sql connect <instance> [--database=DATABASE --user=root]