## xxxxxxxxxxxxxxxxxxxxxx WARNING xxxxxxxxxxxxxxxxxxxxxxxxx
## This will overwrite older mysql patient_database with fresh patient_database with tables in the .sql file of /res folder
## Make sure to have backup 
## ---------------------- WARNING ----------------------

## Details: Database Migrate
## USAGE: Use this script for applying an older database backup (.sql) to a current docker application running the database (.sql)
## Requirement: Before Running, make sure you have .sql file you want to update in the /res folder

## Under Guidance of Professor. Zhi Wei
## Team: Jianlan Ren, Rahul Gautham Putcha, Sai Kiran Pocham, Jiawei Wang
## Created by Rahul Gautham Putcha
## Email: rp39@njit.edu


if [ ! -f $(pwd)'/res/docker.info' ]
then
  echo "[ERROR] BAYER_NJIT_CKD Docker Container not running. Exiting script."
  exit 1
fi
docker_id=$(cat $(pwd)"/res/docker.info" | awk '{print $2}'d)
echo "Docker container detected with container_id:"$docker_id
echo "Creating a new mysql backup. You can find the .sql in "$(pwd)"/res folder."
echo "Note: All older mysql backup save points (.sql) are moved to "$(pwd)"/res/mysql_backup folder"
sudo docker exec -it $docker_id bash -c "python3 mysql_migrate.py"
echo "Backup script execution completed!"