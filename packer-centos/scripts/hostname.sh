#!/bin/bash

if [[ "${HOSTNAME}" == "" ]]; then
    NAME=centos
else
    NAME="${HOSTNAME}"
fi

hostnamectl set-hostname "${NAME}"
sysctl -w kernel.hostname="${NAME}"