## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu
## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Details: Database Backup

if [ ! -f $(pwd)'/res/docker.info' ]
then
  echo "[ERROR] BAYER_NJIT_CKD Docker Container not running. Exiting script."
  exit 1
fi
docker_id=$(cat $(pwd)"/res/docker.info" | awk '{print $2}'d)
echo "Docker container detected with container_id:"$docker_id
echo "Creating a new mysql backup. You can find the .sql in "$(pwd)"/res folder."
echo "Note: All older mysql backup save points (.sql) are moved to "$(pwd)"/res/mysql_backup folder"
sudo docker exec -it $docker_id bash -c "sh mysql_backup.sh"
echo "Backup script execution completed!"