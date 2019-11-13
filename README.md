# Docker for Polynote, Jupyter, Scala and PySpark
This repository provides all the necessary files to build a docker image for running [Polynote](https://polynote.org/), [Jupyter-notebook](https://jupyter.org/), [Scala](https://www.scala-lang.org/), [Spark](https://spark.apache.org/) and a few more data science and machine learning tools.

The docker image is also uploaded to **Dockerhub**, so that one can use the image without going through all the hassles.Docker image can be found [here](https://hub.docker.com/r/sharifuli/polynote-jupyter-scala-spark-ds).   

In the next few section we will discuss how can we build image from Dockerfile. We will also show how to create container from created of downloaded image.

## Create Docker Image from Dockerfile
To create image from the Dockerfile, we need to clone this repository and then change directory to the cloned repository. We need to select a name for our image (for example `dock_polynote:v1` in this case). Then we need to run the following command on the terminal (this has been tested on Ubuntu 18.04 LTS and MacOS, hasn't been tested on Windows). If we want to remove the intermediate images, we should use `--rm`.  
```console
docker build \
    --rm \
    -t dock_polynote:v1 \
    -f Dockerfile \
    .
```
Depending on the speed of the network, this will take quite a while to complete. Upon successful completion, we should be able to see the image by using `docker images` command in the terminal, as shown below.
```console
$ docker images
REPOSITORY          TAG         IMAGE ID            CREATED             SIZE
dock_polynote       v1          6e1bf15182bf        45 hours ago        3.91GB
ubuntu              xenial      5f2bf26e3524        12 days ago         123MB
```
![Docker images](https://i.imgur.com/O6Tx1kl.png)
## Build Container from Dockerhub Image
### Step 1
Download the image using the following command on the terminal (tested on Ubuntu 18.04 LTS and MacOS). Instead of the `latest` tag, we can also use some older tag.
```console
docker pull sharifuli/polynote-jupyter-scala-spark-ds:latest
```
The size of the image is almost 2GB, so it will take some time to download.
### Step 2
Now, we can create a Docker container using the downloaded image or the image we created directly from Dockerfile. We need to remember the following issues:

* We need to provide a name for the container we are going to create (for example `docker_polynote` in this case).
* We need to forward ports for accessing Jupyter-notebook and Polynote from our browser. In this case we are using `8192` for Polynote and `7777` for Jupyter-notebook. We can use any unused port for these purposes.  
* We need to set an environmental variable `PYSPARK_ALLOW_INSECURE_GATEWAY`
* We can mount any local directory to the docker container. In this case we are mounting home `~` directory to `/opt/home_mounted` on the container. We can mount any (one or more) directory to the container.
* We can use `--rm` if we want to remove the container after exit. If we want a persistent container, we need to remove the `--rm` tag.
* We need to change the name of the docker image from `sharifuli/polynote-jupyter-scala-spark-ds:latest` to `dock_polynote:v1` if we want to create container from created image instead of downloaded image.
The command is shown below:
```console
docker run \
    --name docker_polynote \
    -it --rm \
    -p 8192:8192 \
    -p 7777:8888 \
    -e PYSPARK_ALLOW_INSECURE_GATEWAY=1 \
    -v ~:/opt/home_mounted \
    sharifuli/polynote-jupyter-scala-spark-ds:latest
```
This should start both Polynote and Jupyter-notebook server.
### Access Bash
We can access to Docker bash (when the container is running) by using the following command on the terminal. In the terminal we can perform any necessary operation as shown below.
```console
$ docker exec -it docker_polynote bash
root@83ed7c8eb6ac:/opt# ls
home_mounted  nohup.out  polynote  setup_files  spark-2.4.4-bin-hadoop2.7
root@83ed7c8eb6ac:/opt#
```
### Access Polynote
You should be able to access Polynote from the browser using the following link:
* If host is remote server: [http://SERVER_IP:8192](http://SERVER_IP:8192)
* If host is on local: [http://localhost:8192](http://localhost:8192)
The following image shows Polynote accessed from browser on `localhost:8192`.

!(Polynote on browser)[https://imgur.com/gtEjzza]
### Access Jupyter
You should be able to access Jupyter-notebook from the browser using the following link:
* If host is remote server: [http://SERVER_IP:7777](http://SERVER_IP:7777)
* If host is on local: [http://localhost:7777](http://localhost:7777)
The following image shows Jupyter-notebook accessed from browser on `localhost:7777`.

!(Jupyter-notebook on browser)[https://imgur.com/nO1ZKxd]

If we did not change anything so far, the default password is `abcdef`.
#### How to Change Jupyter-notebook password
We can change the Jupyter-notebook password by following one of the following methods.
* **Change `config/jupyter_notebook_config.py` before creating Docker Image**, then create Image from the file and create container from the image.
* **Change `~/jupyter_notebook_config.py` file after creating Docker container.** For this, we need to get into Docker bash terminal and then change the `jupyter_notebook_config.py` file in the home directory. The commands are shown below.
```console
$ docker exec -it docker_polynote bash
root@83ed7c8eb6ac:/opt# cd ~  # change directory to home
root@83ed7c8eb6ac:~# ls -a  # .jupyter is in home directory
.  ..  .bashrc  .cache  .jupyter  .local  .profile  .wget-hsts
root@83ed7c8eb6ac:~# ls .jupyter/
jupyter_notebook_config.py
root@83ed7c8eb6ac:~# cat .jupyter/jupyter_notebook_config.py
# this is for passwrd [abcdef] - change hash for new password
# to generate new hash:
#   Step 1: type ipython in the terminal
#   Step 2: in the ipython terminal type:
#       from notebook.auth import passwd
#   Step 3: then in the ipython terminal type:
#       passwd()
#   Step 4: now follow the prompt and copy the generated password in this file
# it looks like:
#       In [1]: from notebook.auth import passwd
#       In [2]: passwd()
#       Enter password:
#       Verify password:
#       Out[2]: 'sha1:3dfb9c306198:6a917376957053aefb43ef79e5c8b405d2eb7669'
c.NotebookApp.password = u'sha1:e10b54ea7f07:dc33e226e4afc2e0e0aa1d9700864b261753bba4'
root@83ed7c8eb6ac:~#
```
The procedure to change password is provided in `jupyter_notebook_config.py`. Say, for example we want to set a new password `abc123`. We should open a terminal and type `ipython`, this will open an `ipython kernel`. We should just follow the steps shown below:
```console
root@83ed7c8eb6ac:~# ipython
Python 3.6.8 (default, Oct  7 2019, 12:59:55)
Type 'copyright', 'credits' or 'license' for more information
IPython 7.8.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: from notebook.auth import passwd                                                                                                           

In [2]: passwd()                                                                                                                                   
Enter password:
Verify password:
Out[2]: 'sha1:caa85ffb276c:f0cd6a90553a35970519ae8718755dffa3d2525e'

In [3]:   
```
Now we need to copy the created hash and replace the existing hash in the file and then kill the existing Jupyter-notebook and start a notebook again. We can kill Jupyter-notebook using the following command:
```console
kill $(ps -aux | grep [j]upyter-notebook | awk '{print $2}' | head -n 1)
```
Now we can restart the Jupyter notebook using the following command from the docker bash.
```console
$ docker exec -it docker_polynote bash
root@83ed7c8eb6ac:/opt# nohup jupyter-notebook --no-browser --allow-root --ip=0.0.0.0
nohup: ignoring input and appending output to 'nohup.out'
root@83ed7c8eb6ac:/opt#
```
Now if we try to access the notebook from browser it will work with the new password.
### Change Docker Port
You can change the port for Jupiter by editing the configuration file on `~/.jupyter`. You can do the same for Polynote by editing the file `/opt/polynote/polynote/config.yml`.
