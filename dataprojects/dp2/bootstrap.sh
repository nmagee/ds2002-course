#!/bin/bash

export DBHOST=""
export DBUSER=""
export DBPASS=""

/usr/bin/docker run -d -p 80:80 ghcr.io/nmagee/fastapi-demo:latest