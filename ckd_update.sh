## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu
## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Details: Application Update (Backend+Frontend Update)

if [ ! -f $(pwd)'/res/docker.info' ]
then
  echo "[ERROR] BAYER_NJIT_CKD Docker Container not running. Exiting script."
  exit 1
fi
docker_id=$(cat $(pwd)"/res/docker.info" | awk '{print $2}'d)
echo "Docker container detected with container_id:"$docker_id
echo "Updating Application files ..."
sudo docker exec -it $docker_id bash -c "sh /.scripts/update.sh"
echo "Update completed!"