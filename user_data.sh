#!/bin/bash

# Instalação da instância - Docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo chkconfig docker on
sudo systemctl enable docker.service
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mv /usr/local/bin/docker-compose /bin/docker-compose
sudo yum -y install amazon-efs-utils
sudo mkdir /mnt/efs/
sudo chmod +rwx /mnt/efs/

# Executando contêineres via Docker Compose
sudo yum install git -y
cd /mnt/efs
git clone https://github.com/alexlsilva7/atividade_aws_docker.git /home/ec2-user/atividade_aws_docker
# Subir os contêineres
docker-compose up -d

# adicionar o EFS no fstab
echo "IP_OU_DNS_DO_NFS:/ /mnt/nfs nfs defaults 0 0" >> /etc/fstab
# montar o EFS
sudo umount /mnt/efs
sudo mount -a