# README Manual for CKD Patient-Navigator system
## End to End deployment on a EC2 server 
###### Written by Rahul Gautham Putcha

**Purpose**: Complete deployment of CKD Patient Navigator system on a EC2 server

### Description
This file contains instructions for setting up a docker container running the CKD Patient-Navigator.

### Minimum Requirement
- Amazon Linux 2 or Ubuntu Server 18.04 or 20.04 EC2 server
- Instance Type: t2.medium (4GiB Memory) or better
- Storage: 16GB or more
- Security Group with Inbound rules as: 
 - SSH for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)
 - HTTP port 80 for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)
 - TCP port 3000 for IPV4 Anywhere (0.0.0.0/0) & IPV6 Anywhere (::/0)

### Instructions:
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

##### GIT source backend: https://www.github.com/RPG-coder/bayer-njit-backend
##### GIT source frontend: https://www.github.com/sp2728/bayer-njit-frontend
###### Docker image creator: Rahul Gautham Putcha
###### Email: rp39@njit.edu

