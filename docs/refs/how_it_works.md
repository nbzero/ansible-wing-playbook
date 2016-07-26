How does this Ansible works
----------------------------------------------------------
If you finished [Getting started](/docs/tutorials/01_getting_started.md). You've learned first-hand about how this Ansible works, but let spell it out in case you still have questions.

### Design
This Ansible is designed to have four main roles to do four main tasks. Basically explained in four steps with

- Prepare remote host to be ready for deployment.
- Install docker on remote host (required for Ansible-Docker)
- Setup docker machine on remote host (required for Ansible-Docker to be able to remotely manage docker on remote host)
- Deploy Services on remote host with Ansible-Docker

All of which already transformed into Ansible playbooks and roles, for in-depth information of each role please navigate to each role's galaxy page.

- [Host Preparation.](https://galaxy.ansible.com/winggundamth/host_preparation/)
- [Install Docker.](https://galaxy.ansible.com/winggundamth/install_docker/)
- [Manage docker machine.](https://galaxy.ansible.com/winggundamth/docker_machine/)
- [Automated Docker.](https://galaxy.ansible.com/winggundamth/automated_docker/)

### Playbooks and Roles
Playbook is a main component of Ansible, containing yml code that link to a role and tasks that is required for role to be run. We'll use playbook to run our Ansible tasks.

Roles contain tasks to execute. It's downloadable with Ansible Galaxy via
```bash
# -f define force install (new download every times) -r define file to read list of roles to be installed.
ansible-galaxy install -f -r galaxy-requirements.yml
```
In short, Run Ansible playbook and playbook will run Ansible role to execute automated tasks.

### Configuration
Configuration include 3 components. inventories, Variables (group_vars), and files.

- `inventories` define target remote server(s).
- `group_vars` define variables of service. This is main configuration of services.
- `files` is place where required files are located to be copied, for example, nginx configuration file.

Please see [Inventories, Files, Variables]() for more information about configuring.

### Usage
Usage is simple like other Ansible playbook, just run a playbook you need with required variables
```bash
# Example of running host-preparation
# -i define inventory path -e define a variable for playbook
ansible-playbook -i inventories/target_hosts -e host_preparation_host_name=service host-preparation.yml
```
