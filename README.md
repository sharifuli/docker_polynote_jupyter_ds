### Create Docker Image from Dockerfile
```
docker build \
    -t dock_polynote:v1 \
    -f Dockerfile \
    .
```

An Image is already created and uploaded to [dockerhub](https://hub.docker.com/). This image can be downloaded from [this link](https://hub.docker.com/repository/docker/sharifuli/polynote-jupyter-scala-spark-ds/general ).

### Create Docker Container from Image
```
docker run --rm -it \
    --name docker_polynote \
    -p 8192:8192 \
    -p 8888:8888 \
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted \
    dock_polynote:v1
```
