## xxxxxxxxxxxxxxxxxxxxxx WARNING xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
## THIS WILL REMOVE ALL DOCKER IMAGES AND CONTAINERS IN THE SYSTEM 
## Make sure to have backup 
## ---------------------- WARNING --------------------------------

## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu
## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Details: Docker Application Cleaning/ Reset

sudo docker container stop $(sudo docker container ls -aq)
sudo docker container rm $(sudo docker container ls -aq)

