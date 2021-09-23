[gcloud projects add-iam-policy-binding](https://cloud.google.com/sdk/gcloud/reference/projects/add-iam-policy-binding)


##### NAME

gcloud projects add-iam-policy-binding PROJECT_ID --member=MEMBER --role=ROLE [--condition=[KEY=VALUE,…]     | --condition-from-file=CONDITION_FROM_FILE] [GCLOUD_WIDE_FLAG …]


gcloud logging sinks describe --folder=<FOLDER_ID>\
 --format='value(writerIdentity)' sink-specific-logs
 
 gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member=<WRITER_IDENTITY> --role=roles/logging.bucketWriter
  
  
 
 gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member=<WRITER_IDENTITY> --role=roles/logging.bucketWriter
  
//in  
gcloud logging sinks describe --project=ordinal-shard-326901 \
 --format='value(writerIdentity)' nginx-log-sink
//out 
 gcloud logging sinks describe --project=ordinal-shard-326901 \
>  --format='value(writerIdentity)' nginx-log-sink
serviceAccount:p755110927711-578531@gcp-sa-logging.iam.gserviceaccount.com
djmikeyb98@cloudshell:~ (ordinal-shard-326901)$

//in 
gcloud projects add-iam-policy-binding project-alpha-326622 \
  --member=serviceAccount:p755110927711-578531@gcp-sa-logging.iam.gserviceaccount.com \
  --role=roles/bigquery.dataEditor
  
//out

  - serviceAccount:service-1020009008403@container-engine-robot.iam.gserviceaccount.com  role: roles/container.serviceAgent
- members:
  - serviceAccount:service-1020009008403@containerregistry.iam.gserviceaccount.com
  role: roles/containerregistry.ServiceAgent
- members:
  - serviceAccount:1020009008403-compute@developer.gserviceaccount.com
  - serviceAccount:1020009008403@cloudservices.gserviceaccount.com
  - serviceAccount:project-alpha-326622@appspot.gserviceaccount.com
  role: roles/editor
- members:
  - serviceAccount:service-1020009008403@gcp-sa-firestore.iam.gserviceaccount.com
  role: roles/firestore.serviceAgent
- members:
  - user:djmikeyb98@gmail.com
  role: roles/owner
- members:
  - serviceAccount:service-1020009008403@gcp-sa-pubsub.iam.gserviceaccount.com
  role: roles/pubsub.serviceAgent
etag: BwXMohZtEpo=
version: 1
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
