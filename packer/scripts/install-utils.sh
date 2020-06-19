#!/bin/bash
set -eu -o pipefail

echo "Updating awscli..."
sudo pip install --upgrade awscli
sudo pip install future
sudo pip3 install future

# need to use a urllib3 version below 1.25 otherwise cloud-init will fail, because its requests dependency requires a urllib3 <1.25, which will cause the machine to immediately shut down due to 10-power-off-on-failure.conf
sudo pip install urllib3==1.24.*

echo "Installing zip utils..."
sudo yum install -y zip unzip git pigz

echo "Installing bk elastic stack bin files..."
sudo chmod +x /tmp/conf/bin/bk-*
sudo mv /tmp/conf/bin/bk-* /usr/local/bin

echo "Configuring awscli to use v4 signatures..."
sudo aws configure set s3.signature_version s3v4

echo "Installing goss for system validation..."
curl -fsSL https://goss.rocks/install | GOSS_VER=v0.3.6 sudo sh
