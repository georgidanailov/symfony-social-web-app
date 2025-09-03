#!/bin/sh
L=Linux
UNAME=$(uname -s)
if [ "$UNAME" = "$L" ]; then
  USERNAME=nonroot
else
  USERNAME=root
fi

HOST_UID=$(id -u) HOST_GID=$(id -g) HOST_UNAME=$(uname -s) LOGIN_USERNAME=$USERNAME docker compose -f ./docker-compose.yml up --build -d
