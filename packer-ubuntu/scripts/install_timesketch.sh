#!/bin/bash -eux

# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt install -y docker-compose

# Install Timesketch
cd
curl -s -O https://raw.githubusercontent.com/google/timesketch/master/contrib/deploy_timesketch.sh
chmod 755 deploy_timesketch.sh
cd /opt || exit
sudo ~/deploy_timesketch.sh
sudo chown -R malware:malware /opt/timesketch
cd timesketch || exit
sudo docker-compose pull

# Install Timesketch Notebook
sudo mkdir /opt/notebook
sudo chown -R malware:malware /opt/notebook
cd /opt/notebook || exit
cat << EOF > docker-compose.yml
version: '3'
services:
  notebook:
    container_name: notebook
    image: us-docker.pkg.dev/osdfir-registry/timesketch/notebook:latest
    ports:
      - 127.0.0.1:8844:8844
    restart: on-failure
    volumes:
      - /data:/usr/local/src/picadata/
EOF
sudo docker-compose pull

# Download plaso
sudo docker pull log2timeline/plaso
