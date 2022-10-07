#!/bin/bash

if [[ "x${HOSTNAME}" == "x" ]]; then
    NAME=centos
else
    NAME="${HOSTNAME}"
fi

hostnamectl set-hostname "${NAME}"
sysctl -w kernel.hostname="${NAME}"