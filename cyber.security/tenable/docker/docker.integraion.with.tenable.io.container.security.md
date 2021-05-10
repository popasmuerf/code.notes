#Docker Integration
(source)[https://www.youtube.com/watch?v=GtKTwnVdYZc]
# first login to docker  using your api key
docker login -u -p  registry.cloud.tenable.com 


#pull the image
docker  pull mongo:latest #pull the image


#tag the image
docker tag mongo:latest registry.cloud.tenable.com/mongo:demo


#docker push image
docker push registry.cloud.tenable.com/mongo
