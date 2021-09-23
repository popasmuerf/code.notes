[BQ DataSets](https://codelabs.developers.google.com/codelabs/bigquery-cli#2)

security=ordinal-shard-326901


## Run command to confirm that we are authenticated:
gcloud auth list 
gcloud config list project



## Create a dataset
bq mk bq_load_codelab

## View dataset properties
## Verify that you created the dataset
## by viewing the dataset's properties with the 
## bq show

bq show bq_load_codelab


## created a log dedicated project 
## It can be one of the 2 projects or in 
## other ones, and then create a log bucket 

## create a BigQuery dataset

gcloud logging buckets create --location=global \
--retention-days=7 --project=LOG_PROJECT_ID specfific-log



#  then create an aggregated sink on your organization or
## folder

