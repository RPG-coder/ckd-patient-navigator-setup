#!/bin/bash
## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu
## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Details:
##   Use this file for Amazon Linux 2 platform specific intallations
##   of CKD Patient Navigation system.
##              DO THIS ON YOUR LOCAL SYSTEM
##   <<<<<<<<<<<< Requires Root permissions >>>>>>>>>>>>>>>>

# Installing Docker
sudo apt-get update
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y unzip
pip3 install gdown

sudo apt-get install -y docker.io

echo "-----------------------------"
echo "Installed $(docker --version)"
echo "-----------------------------"

sudo service docker start

echo "----------------------"
echo "Started Docker service"
echo "----------------------"

printf "\n\n\n"
echo "--------------------------------------------"
echo "CKD Patient Navigator Deployment Application"
echo "--------------------------------------------"
echo '
import gdown
url = "https://drive.google.com/uc?id=1qUPge1u9hvpRgs2WoP2gGNjukGhOy2nI"
output = "bayer-njit-ckd4ec2.zip"
gdown.download(url, output, quiet=False)
' > z.py
python3 z.py
unzip bayer-njit-ckd4ec2.zip
sudo docker load < bayer-njit-ckd4ec2.tar


if [ -f '$(pwd)/res/done.log' ]
then
    rm '$(pwd)/res/done.log'
fi


sudo docker run -dit -p 8980:80 -p 8979:3000 -v "$(pwd)/res":/temp/ bayer-njit-ckd4ec2

echo "Use the status script to check the status of you system:"
echo "$ sh status.sh"

echo "--------------------------------------------"
echo "    The deployment may take from 5-10 min"
echo "--------------------------------------------"