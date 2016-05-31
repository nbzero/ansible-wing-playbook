Getting started
===========================================================================

Ansible is a great tool to do infrastructure as a code. It can do configuration management with minimum requirement that you need only ssh client-server and python. What powerful about Ansible is the structure that consist tasks, roles, playbooks and inventories that easy to understand with a lot of modules that come from community to expand capability of Ansible.

Docker also a great platform to build, ship and run. You can build Docker Image from Dockerfile that basically is bash shell script. Then ship it to Docker Registry and pull it from most of the place to deploy your application from your machine to production with the same exactly environment that you built. It comes with a lot of tools such as Docker Machine and Docker Swarm to control your servers or Docker Compose that will defined and run multiple containers.

Many people asking what is the difference between Ansible and Docker. Do we just pick one or need it both? My answer is yes, you need it both. Docker is a great tool to quickly deploy application but it still lacks how to do pre or post deployment such as restore the backup data, configure a database cluster. Or even if you need to maintain your application such as reconfiguration, tuning or backing up data. So Ansible is come to fill the gap and make it the perfect match for infrastructure as a code.

This inspire me to develop this repository. Make a sample so people can see that infrastructure as a code is not that hard with help from Ansible and Docker. So let's get started

Prepare
---------------------------------------------------------------------------

- [Install Docker 1.11.1 on your machine](https://docs.docker.com/engine/installation/)
- [Install Docker Machine 0.7.0 on your machine](https://docs.docker.com/machine/install-machine/)
- [Install Ansible 2.1 on your machine](http://docs.ansible.com/ansible/intro_installation.html)
- Clone this repository and install all dependencies roles
```bash
git clone https://github.com/winggundamth/ansible-wing-playbook.git
cd ansible-wing-playbook
ansible-galaxy install -f -r galaxy-requirements.yml
```

Prepare Ansible inventory file
---------------------------------------------------------------------------
- Prepare inventory file by copy ```inventories/host_preparation.example``` and make your own inventory file
```bash
# Please see that I copy it to target_hosts file
cp inventories/host_preparation.yml inventories/target_hosts
vi inventories/target_hosts
```
- You can read more about [how to make inventory file here](http://docs.ansible.com/intro_inventory.html). Basically this will be the list of all your servers and put it in group. Each server you have to put ssh variable such as
  - **ansible_user** is a ssh user
  - **ansible_host** is a ip of remote server
  - **ansible_port** is a port that will ssh to. **This is mandatory or reboot task won't work**
  - **host_preparation_host_name** is a hostname that host_preparation role will configure it for you
- Read more about ```[all:vars]``` in next section

Prepare your Ubuntu server with host_preparation role
---------------------------------------------------------------------------

- In inventory file, you will see ```[all:vars]``` section that will point to variable file that each role will read. For host_preparation role you need to put ```host_preparation_vars_file``` variable and point to ```vars/host_preparation.yml``` that you will create this file in next bullet
- Copy ```vars/host_preparation.yml.example``` to make your own configuration
```bash
cp vars/host_preparation.yml.example vars/host_preparation.yml
vi vars/host_preparation.yml
```
- This variable file is heavily commented so you can understand what it does. All the variables show in this file are the default that role will use even it commented. The uncommented variables are mean that you should take a look and change it to match your needed. So let's look at ```host_preparation_ntp_server``` and change it to your nearest time server. Another place that you should look is ```host_preparation_global_authorized_keys_path``` that will copy authorized_keys from your machine to remote host.
- From ```host_preparation_global_authorized_keys_path``` variable. You must create ```files/authorized_keys``` and put your public key in this file
```bash
# You can also copy your public key as authorized_keys
cp ~/.ssh/id_rsa.pub files/authorized_keys
```
- Time to run playbook!
```bash
# -i is point to inventory file that we created on previous section
# You have to put --ask-pass and --ask-become-pass if you use password to ssh
# to the remote server
ansible-playbook -i inventories/target_hosts --ask-pass --ask-become-pass \
host-preparation.yml
```
- You can read what exactly host_preparation role does from here https://galaxy.ansible.com/winggundamth/host_preparation/

Install docker on remote machine
---------------------------------------------------------------------------

- Let's go back to ```inventories/target_hosts``` inventory file again. In ```[all:vars]``` section you need to put ```install_docker_vars_file``` variable that use by ```install-docker.yml``` playbook and point to ```vars/install_docker.yml``` that you will create this file in next bullet. So combine with host_preparation role it will be look like this
```
[vps]
vps-01 ansible_user=ubuntu host_preparation_host_name=vps01 ansible_host=192.168.77.77 ansible_port=22

[all:vars]
host_preparation_vars_file=vars/host_preparation.yml
install_docker_vars_file=vars/install_docker.yml
```
- Copy ```vars/install_docker.yml.example``` to make your own configuration
```bash
cp vars/install_docker.yml.example vars/install_docker.yml
```
- You can take a look at ```vars/install_docker.yml``` but I won't change anything since docker_machine role will do for us in next section
- Run playbook
```bash
ansible-playbook -i inventories/target_hosts install_docker.yml
```
- You can read what exactly install_docker role does from here https://galaxy.ansible.com/winggundamth/install_docker/

Prepare Docker Machine with docker_machine role
---------------------------------------------------------------------------

I usually use docker-machine with generic driver to control docker on remote machine. So I created Ansible docker_machine role to automated do this

- Again edit ```inventories/target_hosts``` file in ```[all:vars]``` section. You need to put ```docker_machine_vars_file``` variable that use by ```docker-machine.yml``` playbook and point to ```vars/docker_machine.yml``` that you will create this file in next bullet
- Copy ```vars/docker_machine.yml.example``` to make your own configuration
```bash
cp vars/docker_machine.yml.example vars/docker_machine.yml
vi vars/docker_machine.yml
```
- Take a look at ```vars/docker_machine.yml```. I always configure overlayfs by putting this variable
```yaml
docker_machine_extra_parameters: --engine-storage-driver overlay
```
- Run playbook
```bash
ansible-playbook -i inventories/target_hosts manage-docker-machine.yml
```
- After you successful ran the playbook. You will see all docker-machine certificate files at ```files/docker-machine/*```. We will use this for next section.
- You can read what exactly docker_machine role does from here https://galaxy.ansible.com/winggundamth/install_docker/

Let's create nginx container
---------------------------------------------------------------------------

So after we successful prepare everything. Now it time for real deploy container.

- Edit ```inventories/target_hosts``` file in ```[all:vars]``` section. You need to put ```nginx_container_vars_file``` variable that use by ```nginx-container.yml``` playbook and point to ```vars/nginx_container.yml``` that you will create this file in next bullet
- Copy ```vars/nginx_container.yml.example``` to make your own configuration
```bash
cp vars/nginx_container.yml.example vars/nginx_container.yml
vi vars/nginx_container.yml
```
- Take a look at ```vars/docker_machine.yml``` and learn each variable what it does. But actually you don't need to put or change anything.
- In ```files/groups/preproduction-example/nginx/*``` will have all initial nginx configuration file. You have to copy and rename it to the group name you want to deploy nginx container. For example if your inventory file look like this
```
[production]
prod-01 ansible_user=ubuntu ansible_host=10.10.10.11 ansible_port=22
prod-02 ansible_user=ubuntu ansible_host=10.10.10.12 ansible_port=22

[preproduction]
pre-01 ansible_user=ubuntu ansible_host=10.10.10.21 ansible_port=22

[all:vars]
host_preparation_vars_file=vars/host_preparation.yml
install_docker_vars_file=vars/install_docker.yml
docker_machine_vars_file=vars/docker_machine.yml
nginx_container_vars_file=vars/nginx_container.yml
```
If you want to deploy nginx container in to production server only. You have to create directory name ```production``` and copy whole nginx directory to it
```bash
mkdir files/production
cp -av files/preproduction-example/nginx file/production/
```
- Just change all the nginx configuration files as you want such as change number of worker in ```nginx.conf``` or add ```sites-available``` and make a symlink file in ```sites-enabled```.
- Run playbook to deploy nginx container with configuration
```bash
ansible-playbook -i inventories/target_hosts nginx-container.yml
```
- Open your web browser to see your nginx default site!
- You can read what exactly nginx_container role does from here https://galaxy.ansible.com/winggundamth/nginx_container/
