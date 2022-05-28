#!/bin/bash
## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu
## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Details:
##   INITIAL SETUP FILE
##   Use this file for Amazon Linux 2 platform specific intallations
##   of CKD Patient Navigation system.
##              DO THIS ON YOUR LOCAL SYSTEM
##   <<<<<<<<<<<< Requires Root permissions >>>>>>>>>>>>>>>>

# Installing Docker
sudo yum update
sudo yum install -y python3 python3-pip
sudo yum install -y unzip
pip3 install gdown

sudo yum install -y docker

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

if [ -f $(pwd)'/res/docker.info' ]
then
    sudo docker container stop $(cat $(pwd)'/res/docker.info' | awk '{print $2}')
    sudo docker container rm $(cat $(pwd)'/res/docker.info' | awk '{print $2}')
    sudo docker image rm $(cat $(pwd)'/res/docker.info' | awk '{print $1}')
fi

gdown https://drive.google.com/uc?id=1qUPge1u9hvpRgs2WoP2gGNjukGhOy2nI
unzip bayer-njit-ckd4ec2.zip
sudo docker load < bayer-njit-ckd4ec2.tar

if [ -f $(pwd)'/res/done.log' ]
then
    sudo rm $(pwd)'/res/done.log'
fi


dockerid=$(sudo docker run -dit -p 8980:80 -p 8979:3000 -v "$(pwd)/res":/temp/ bayer-njit-ckd4ec2)
printf "\nimage_id:$(sudo docker images | grep bayer-njit-ckd4ec2 | awk '{print $3}')\ncontainer_id:$dockerid\n"
echo "$(sudo docker images | grep bayer-njit-ckd4ec2 | awk '{print $3}') $dockerid" > "$(pwd)/res/docker.info"

echo "Use the status script to check the status of you system:"
echo "$ sh status.sh"

echo "--------------------------------------------"
echo "    The deployment may take from 5-10 min"
echo "--------------------------------------------"

echo "Waiting for the setup to finish."

while [ ! -f $(pwd)'/res/done.log' ]
do
  sleep 10
  printf "."
done
printf "\n"
echo "Setup finished."