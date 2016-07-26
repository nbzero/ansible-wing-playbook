Getting started
===========================================================================
Let's start with definition
---------------------------------------------------------------------------
Ansible is a great tool to do infrastructure as a code. It can do configuration management with minimum requirement that you need only ssh client-server and python. What powerful about Ansible is the structure that consist tasks, roles, playbooks and inventories that easy to understand with a lot of modules that come from community to expand capability of Ansible.

Docker also a great platform to build, ship and run. You can build Docker Image from Dockerfile that basically is bash shell script. Then ship it to Docker Registry and pull it from most of the place to deploy your application from your machine to production with the same exactly environment that you built. It comes with a lot of tools such as Docker Machine and Docker Swarm to control your servers or Docker Compose that will defined and run multiple containers.

Many people are asking what is the difference between Ansible and Docker. Do we just pick one or need it both? My answer is yes, you need it both. Docker is a great tool to quickly deploy application but it still lacks how to do pre or post deployment such as restore the backup data, configure a database cluster. Or even if you need to maintain your application such as reconfiguration, tuning or backing up data. So Ansible is come to fill the gap and make it the perfect match for infrastructure as a code.

This inspire me to develop this repository. Make a sample so people can see that infrastructure as a code is not that hard with help from Ansible and Docker. So let's get started

What will we do? Deploying GitLab.
---------------------------------------------------------------------------
You're going to learn infrastructure as a code by deploying GitLab CE from scratch!

To visualize your tasks in simple steps:

- Create a completely new server for deployment.
- Use Ansible to manage server to make it ready to deploy. For example, install packages dependencies, docker, etc.
- Use Ansible to create Docker Machine Certificate on the server for Ansible to use.
- Use Ansible to deploy GitLab service via Docker.

Preparation
---------------------------------------------------------------------------
*Please note that this tutorial is made with specific version of Docker, Ansible and Ubuntu OS. It could be different on other versions.*

- [Install Docker 1.11.2 on your machine.](https://docs.docker.com/engine/installation/)
- [Install Docker Machine 0.7.0 on your machine.](https://docs.docker.com/machine/install-machine/)
- [Install Ansible 2.1 on your machine.](http://docs.ansible.com/ansible/intro_installation.html)
- Install Ansible 2.1 patch on your machine. (This step won't be needed on Ansible 2.2 or above)
```bash
# Change the output to your docker_common.py file on your machine.
# Try running 'sudo find / | grep docker_common.py' to find your docker_common.py path.
wget -O /ansible/lib/python2.7/site-packages/ansible/module_utils/docker_common.py https://raw.githubusercontent.com/ansible/ansible/devel/lib/ansible/module_utils/docker_common.py

# Change the output to your docker_container.py file on your machine.
# Try running 'sudo find / | grep docker_container.py' to find your docker_container.py path.
wget -O /ansible-dev/lib/python2.7/site-packages/ansible/modules/core/cloud/docker/docker_container.py https://raw.githubusercontent.com/ansible/ansible-modules-core/devel/cloud/docker/docker_container.py
```
- Create a bare Ubuntu 14.04 LTS server for GitLab deployment. (With [digitalocean](https://www.digitalocean.com), etc.)
- Clone or fork this repository and install all dependencies roles on your machine.
```bash
# Clone this or forked repository.
git clone https://github.com/winggundamth/ansible-wing-playbook.git

# Install dependencies roles with Ansible Galaxy.
cd ansible-wing-playbook
ansible-galaxy install -f -r galaxy-requirements.yml
```

1. Prepare Ansible inventory and authorized_keys files
---------------------------------------------------------------------------
*Basically inventory file is the list of your server(s) put in group(s), this file will tell Ansible where target servers are.*

- Prepare inventory file by copy `inventories/target_hosts.example` and make your own inventory file.
```bash
# Notice that I copy it to target_hosts file and edit it.
cp inventories/target_hosts.example inventories/target_hosts
vi inventories/target_hosts
```
- Edit inventory to point to your remote server.
```yml
# See example in the file.
[GROUP_NAME]
MACHINE_NAME ansible_user=SSH_USERNAME ansible_host=SSH_IP ansible_port=SSH_PORT
```
  - **ansible_user** is a ssh user
  - **ansible_host** is a ip of remote server
  - **ansible_port** is a port that will ssh to. **_This is mandatory or reboot task won't work_**

*authorized_keys file need to be prepared before running Ansible. Ansible will put this authorized_keys inside your server to configure ssh permission on your remote host.*

- Prepare authorized_keys by adding your set of keys into `files\authorized_keys`
```bash
# Put your own set of keys in authorized_keys file
cp files/authorized_keys.sample files/authorized_keys
vi files/authorized_keys
```

2. It's time for host-preparation playbook
---------------------------------------------------------------------------
*Host Preparation is a playbook that call host_preparation role to tune your server to be ready for services deployment. [More Information](https://galaxy.ansible.com/winggundamth/host_preparation/).*

- Run host-preparation.yml playbook.
```bash
# -i point to inventory file that we created on previous section.
# -e is to add an environment to playbook. host_preparation_host_name is needed to set remote hostname.
ansible-playbook -i inventories/target_hosts -e host_preparation_host_name=gitlab host-preparation.yml
```
- Look at your command line go!

3. Running install-docker playbook
---------------------------------------------------------------------------
*Install docker is a playbook that call install-docker role to install docker on your server. [More information](https://galaxy.ansible.com/winggundamth/install_docker/).*

- Run playbook
```bash
ansible-playbook -i inventories/target_hosts install-docker.yml
```
- You can check at remote server after Ansible's done to see if docker is already installed.

4. Prepare Docker Machine with manage-docker-machine playbook
---------------------------------------------------------------------------
*Docker Machine is a playbook that call docker_machine role to create docker machine for controlling docker on remote server. [More information](https://galaxy.ansible.com/winggundamth/docker_machine/)*

- Run playbook
```bash
ansible-playbook -i inventories/target_hosts manage-docker-machine.yml
```
- After you successfully ran the playbook. You will see all docker-machine certificate files at ```files/docker-machine/*```. We will use this for next section.

5. Let's create GitLab container
---------------------------------------------------------------------------
*All steps before is just preparation for real deployment. We will use automated-docker playbook here to deploy GitLab. [More information](https://galaxy.ansible.com/winggundamth/automated_docker/).*

- For now, know that automated-docker is one big role that we'll use to deploy every services, let's run the playbook with following command first
```bash
# automated_docker_name is variable that define which service to be deploy.
ansible-playbook -i inventories/target_hosts -e automated_docker_name=gitlab automated-docker.yml
```
- And this is where magic happens. After the playbook finished running try checking docker container on your server, or even try to access GitLab that just got deployed!.
```bash
# See docker container on remote server
docker ps
# Access your GitLab
http://HOST_IP:10080
```

What just happened!?
---------------------------------------------------------------------------
Yes. I know you've just following boring steps and suddenly, GitLab of your own just got deployed.

Let's remember our tasks a bit and let's try changing them into playbook name here.

- Create a completely new server for deployment. **_(No playbook)_**
- Use Ansible to manage server to make it ready to deploy. For example, install packages dependencies, docker, etc. **_(host-preparation.yml, install-docker.yml)_**
- Use Ansible to create Docker Machine Certificate for the server. **_(manage-docker-machine.yml)_**
- Use Ansible to deploy GitLab service via Docker. **_(automated_docker.yml)_**

As you can see, server preparation and deployment process have been taken care of by Ansible Playbooks combined with Docker, in other word, Ansible and Docker take care of everything for us when we got a bare server running. How easy is it?

What's next?
---------------------------------------------------------------------------
You now have a rough idea of how this infrastructure as a code works. Next is to dive deeper to take a look at how can you configure your deployment. For example, you already have nginx configuration files, how can you deploy nginx with this infrastructure as a code with your configuration files attached to it.

But before that you can take a look at [How does this Ansible works](docs/refs/how_it_works.md) to have clear picture of what you've just done. After that you can proceed to next step.
