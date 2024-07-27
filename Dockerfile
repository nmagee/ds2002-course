FROM ubuntu:22.04
LABEL maintainer="Neal Magee <nem2p@virginia.edu>"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN apt update
RUN apt install -y software-properties-common curl
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
  gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN apt update && apt upgrade -y
RUN apt install -y python3 python3-dev python3-pip nano \
  git net-tools jq zip unzip dnsutils httpie tzdata wget htop \
  iputils-ping redis gsutil apt-transport-https pkg-config \
  ca-certificates gnupg gcc python3-setuptools libffi-dev \
  mongodb-org libmysqlclient-dev \
  && apt clean autoclean && apt autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN ln -s /usr/bin/python3.10 /usr/bin/python

RUN rm -rf /var/lib/apt/lists/*
RUN mkdir "/home/host"

WORKDIR /root
COPY requirements.txt requirements.txt
# RUN /usr/bin/pip install -r requirements.txt
