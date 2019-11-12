### Create Docker Image from Dockerfile
```
docker build \
    --build-arg USER=$USER \
    --build-arg UID=$UID \
    --build-arg GID=$GID \
    --build-arg PW=dockerpw \
    --build-arg ROOTPW=dockerroot \
    -t dock_polynote:v1 \
    -f Dockerfile \
    .
```

An Image is already created and uploaded to [dockerhub](https://hub.docker.com/). This image can be downloaded from [this link](https://hub.docker.com/repository/docker/sharifuli/polynote-jupyter-scala-spark-ds/general ).

### Create Docker Container from Image
```
docker run --rm -it -u $(id -u):$(id -g) \
    --name docker_polynote \
    -p 8192:8192 \
    -p 8888:8888 \
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v /home/$USER:/opt/mounted \
    dock_polynote:v1
```
