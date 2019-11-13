### Create Docker Image from Dockerfile
```
docker build \
    --rm \  # remove intermediate images
    -t dock_polynote:v1 \
    -f Dockerfile \
    .
```

An Image is already created and uploaded to [dockerhub](https://hub.docker.com/). This image can be downloaded from [this link](https://hub.docker.com/repository/docker/sharifuli/polynote-jupyter-scala-spark-ds/general ).

## Build Container from Dockerhub Image
### Step 1
Download the image using
```
docker pull sharifuli/polynote-jupyter-scala-spark-ds:v2
```
### Step 2
Build docker container using the following command
```
docker run \
    --name docker_polynote \
    -it --rm \
    -p 8192:8192 \
    -p 7777:8888 \
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted \
    sharifuli/polynote-jupyter-scala-spark-ds:v2
```
#### Explanation
```
docker run 
    --name docker_polynote  # give a custom name for container
    -it --rm # remove [--rm] tag if want the container to persist
    --name docker_polynote  # give a custom name for container
    -p 8192:8192 # select port for polynote (change if necessary)
    -p 7777:8888  # select port for jupyter (change if necessary)
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted # mounting host home(/~) direcotry to /opt/home_mounted
    dock_polynote:v1 # iamge name (change according to the image name)
```

### Access Jupyter 
You should be able to access Jupiter notebook from the browser using the following link:
* If host is remote server: [http://SERVER_IP:7777](http://SERVER_IP:7777)
* If host is on local: [http://localhost:7777](http://localhost:7777)

### Access Polynote 
You should be able to access Jupiter notebook from the browser using the following link:
* If host is remote server: [http://SERVER_IP:8192](http://SERVER_IP:8192)
* If host is on local: [http://localhost:8192](http://localhost:8192)

### Access Bash
Write the following command on terminal (when the container is running)
```
docker exec -it [container_name] bash
```

**Jupyter password:** The default password for the Jupiter notebook is `abcdef`. However you can change the password by following the instruction (changing the hash value) in the file. <br>
**Change forwarded port:** You can also change the forwarded port by changing the value `7777` or `8192` to something else (to some other free port). <br>
**Change docker port:** You can change the port for Jupiter by editing the configuration file on `~/.jupyter`. You can do the same for Polynote by editing the file `/opt/polynote/polynote/config.yml`.
