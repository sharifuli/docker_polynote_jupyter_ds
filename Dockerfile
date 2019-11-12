FROM ubuntu:latest

# Identify the maintainer of an image
LABEL maintainer="msislam@sfu.ca"

# copy files from local to container
COPY . /opt/setup_files
WORKDIR /opt

# setup default user name and password
ARG USER=docker
ARG PW=dockerpw
ARG ROOTPW=dockerroot
ARG UID=1001
ARG GID=1001

# mention version numbers
ARG POLYNOTE_VERSION="0.2.12"
ARG SCALA_VERSION="2.11"
ARG DIST_TAR="polynote-dist.tar.gz"

# adding user and rootuser
RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | chpasswd
RUN echo "root:${ROOTPW}" | chpasswd

# install packages
RUN apt-get update && apt-get install -y \
  wget \
  default-jdk \
  python3 \
  python3-dev \
  python3-pip \
  python-setuptools \
  build-essential \
  git \
  vim \
  scala

# download polynote
RUN if test "${SCALA_VERSION}" = "2.12"; then export DIST_TAR="polynote-dist-2.12.tar.gz"; fi && \
  wget -q https://github.com/polynote/polynote/releases/download/$POLYNOTE_VERSION/$DIST_TAR && \
  tar xfzp $DIST_TAR && \
  echo "DIST_TAR=$DIST_TAR" && \
  rm $DIST_TAR

# download spark
RUN wget -q https://www-us.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz && \
  tar xfz spark-2.4.4-bin-hadoop2.7.tgz && \
  rm spark-2.4.4-bin-hadoop2.7.tgz

# set environmental variables
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV SPARK_HOME=/opt/spark-2.4.4-bin-hadoop2.7
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

RUN python3 -m pip install --upgrade pip
RUN pip install -r /opt/setup_files/requirements.txt

RUN chmod -R 755 /opt/*
RUN chown -R ${UID}:${GID} /opt/*
USER ${UID}:${GID}
WORKDIR /opt

# copy config.yml file to polynote directory
RUN cp /opt/setup_files/config/config.yml /opt/polynote/

# create jupyter config files it will be created in home(~/) folder
RUN jupyter notebook --generate-config
RUN cp /opt/setup_files/config/jupyter_notebook_config.py ~/.jupyter/

EXPOSE 8192
EXPOSE 8888
CMD . setup_files/command.sh
