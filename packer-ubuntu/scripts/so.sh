#!/bin/bash

echo "debconf debconf/frontend select noninteractive" | sudo debconf-set-selections
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:securityonion/stable
sudo apt-get update
sudo apt-get -y install securityonion-all syslog-ng-core
sudo apt-get -y dist-upgrade
