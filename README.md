### Create Docker Image from Dockerfile
```
docker build \
    --rm \  # remove intermediate images
    -t dock_polynote:v1 \
    -f Dockerfile \
    .
```

An Image is already created and uploaded to [dockerhub](https://hub.docker.com/). This image can be downloaded from [this link](https://hub.docker.com/repository/docker/sharifuli/polynote-jupyter-scala-spark-ds/general ).

### Create Docker Container from Image
```
docker run -it  \ 
    --rm \ 
    --name docker_polynote  \
    -p 8192:8192 \
    -p 7777:8888  \
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted \
    dock_polynote:v1
```
#### Explanation
```
docker run -it  \
    --rm # remove [--rm] tag if want the container to persist
    --name docker_polynote  # give a custom name for container
    -p 8192:8192 # select port for polynote (change if necessary)
    -p 7777:8888  # select port for jupyter (change if necessary)
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted # mounting host home(/~) direcotry to /opt/home_mounted
    dock_polynote:v1 # iamge name (change according to the image name)
```

