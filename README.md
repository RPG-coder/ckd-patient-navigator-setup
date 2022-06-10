# README Manual for CKD Population Navigator system
## End to End deployment on a EC2 server 
###### Written by Rahul Gautham Putcha

**Purpose**: Complete deployment of CKD Population Navigator system on a EC2 server

### Description
This file contains instructions for setting up a docker container running the CKD Population Navigator.

### General Script Usage
Few scripts for CKD Population Navigator

1. Initial setup [Video_Demo](https://youtu.be/gWRzeiYaZBo)

  i. Initial setup on RHEL/Amazon Linux 2
     
     $ sh rhel_run.sh 

  ii. Initial setup on Ubuntu OS
     
     $ sh debian_run.sh

  iii. If you want to check the status of your initial application setup without via async script call, use:
     
     $ sh status.sh # after running a debian_run.sh or rhel_run.sh in background 

2. Docker clean: use this only when you find error in Initial setup due to running of an older version of CKD Population Navigator app
  
    $ sh docker_clean.sh

3. Application ( Backend + Frontend ) update
  
    $ sh ckd_update.sh

4. Database Backup [VideoDemo](https://youtu.be/bEpSrraX-V0): This will create a new .sql file for the current database in ./res folder. Also, all older versions of .sql backup files are maintained in ./res/mysql_backup folder 
   
   $ sh mysql_backup.sh

5. Database Migrate [VideoDemo]([https://youtu.be/bEpSrraX-V0?t=342): Use this to apply database or db table data by custom .sql files in res folder. You can use this to apply any one of older .sql db backup by moving them to res folder before running rhis script.
   
   $ sh mysql_migrate.sh

### Minimum Requirement
- Amazon Linux 2 or Ubuntu Server 18.04 or 20.04 EC2 server
- Instance Type: t2.medium (4GiB Memory) or better
- Storage: 16GB or more
- Security Group with Inbound rules as: 
 - SSH for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)
 - HTTP port 80 for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)
 - TCP port 3000 for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)

### Security Group Settings
For more details on setting the security group setting, please view the image presented in the link below

[Security Group setting](https://drive.google.com/file/d/1wT9QNsBgV9w0Q-DWWG-xEdnmnQj_HMHr/view?usp=sharing)

### Instructions:

You can follow this [Video_Demo](https://youtu.be/gWRzeiYaZBo) instead of skimming through the steps below.

1. What you need before running, 
  * Install Git
    - For Amazon Linux 2 server
      - $ sudo yum install -y git
    - For Ubuntu server
      - $ sudo apt-get install -y git
  * Clone the **RPG-coder/ckd-patient-navigator-setup** repo:
    - $ git clone https://github.com/RPG-coder/ckd-patient-navigator-setup.git
    - Next, depending on your EC2 instance AMI type you are provided with two kinds of **run.sh** files
      - **'debian_run.sh'**, for installing docker and setting up the CKD Patient-Finder app on **Ubuntu OS**
      - **'rhel_run.sh'**, for installing docker and setting up the CKD Patient-Finder app on **RHEL (CentOS) or Amazon Linux 2 OS**
    - **NOTE**: Please make sure your **port 80 (HTTP)** and **port 3000 (TCP)** are accessable to the world, i.e. Security Group attached to the EC2 has a rule for **HTTP 80** and **TCP 3000** set to CIDR **0.0.0.0/0**

  * We are assuming that you are working on a **EC2 server instance** for rest of this tutorial.

2. Installing docker on your respective EC2 Linux machine (Amazon Linux 2 or Ubuntu server)
  - $ cd ckd-patient-navigator-setup
  - For Amazon Linux 2 server execute the script,
      - $ sh rhel_run.sh
  - For Ubuntu server execute the script,
      - $ sh debian_run.sh

3. After running a script from above:
  - By default **run.sh** script is configured to share your **website** on your EC2 HTTP port (or equivalently the port no. 80).
  - By default **run.sh** script is configured to share your **backend** on your EC2 TCP port 3000.
  - For more information on setting up the Security group for EC2, please visit [Security group for EC2](https://www.youtube.com/watch?v=PFfDq9PwTkg)

<hr/>

## Database Backups (for MySQL/Docker)

You can follow this [VideoDemo](https://youtu.be/bEpSrraX-V0) instead of skimming through below content.

- If you want to backup you current database tables, then execute below script:
  - sh mysql_backup.sh # note this script must be executed in the folder containing the res folder
- This will create a "mysql_backup" folder inside the "res" folder along with automatically moving all older versioned .sql database backup files into this folder.
- After moving this script will also create a new .sql backup of the database used by the currently running CKD Population Navigator application.
- In other words, this script will ultimately create a .sql file (patient_database_YYYY-MM-DD-hh-mm-ss.sql).

## Database Migrate (for MySQL/Docker)

You can follow this [VideoDemo]([https://youtu.be/bEpSrraX-V0?t=342) instead of skimming through below content.

- IMPORTANT NOTE: The script in this section will delete the older database before migrating. It is advised to create a backup mentioned in above section before hand and have the copy of the .sql result product file from the backup in a safe location, before proceeding. 
- If you want to migrate to older database version a .sql backup dump file (inside the "mysql_backup" folder) or add-on new tables from a custom .sql along with the tables from your current database, then:
  - Create a backup of current database by the instruction mentioned in above section. This will create a .sql file (patient_database_YYYY-MM-DD-hh-mm-ss.sql). (Recommended: If necessary, please create a copy of this in a seperate folder)
  - If you are migrating database from newer to a older version?
    - (Recommended: After having a copy of current .sql backup) 
    - Replace the current patient_database_YYYY-MM-DD-hh-mm-ss.sql backup with your patient_database_YYYY-MM-DD-hh-mm-ss.sql backup file of choice from "mysql_backup" folder  
    - (Delete current backup & Place another patient_database_YYYY-MM-DD-hh-mm-ss.sql file). 
    - IMPORTANT: Make sure the LATEST/CURRENT or MULTIPLE patient_database_YYYY-MM-DD-hh-mm-ss.sql are not present in the res folder when migrating database to a older version of patient_database_YYYY-MM-DD-hh-mm-ss.sql backup.
  - If you are introducing custom tables into the mysql application database?
    - This can be due to several reasons (Few ex: Introducing new functionalities on API, Data Compliance reasons requiring tables data to be present within same database, etc)
    - Place (Copy) all of your custom .sql file inside the "res" folder
    - Make sure you have your desired patient_database_YYYY-MM-DD-hh-mm-ss.sql within the "res" before doing migration.

  - sh mysql_migrate.sh # note this script must be executed in the folder containing the "res" folder

<hr/>

##### GIT source backend: https://www.github.com/RPG-coder/bayer-njit-backend
##### GIT source frontend: https://www.github.com/sp2728/bayer-njit-frontend
###### Docker image creator: Rahul Gautham Putcha
###### Email: rp39@njit.edu

