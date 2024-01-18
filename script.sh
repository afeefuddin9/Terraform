#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
sudo ansible --version >/home/ec2-user/ansible_version.txt

#Confugring Ansible host file
ip_address=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
echo "[demo]" >>/etc/ansible/hosts
echo "$ip_address" >>/etc/ansible/hosts

echo "Hello" >>/home/ec2-user/test.txt
sleep 10

#Running deploy.yml to configure required packages
sudo ansible-playbook deploy.yml
echo "Hello Ansible" >>/home/ec2-user/test1.txt
#deleting deploy file post installation
sleep 20
sudo rm -rf /home/ec2-user/deploy.yml
