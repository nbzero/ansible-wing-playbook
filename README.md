
Infrastructure as a code with Ansible + Docker
==========================================================
This repository is the skeleton to do infrastructure as a code with Ansible + Docker. Assume that you already have understanding of Ansible and Docker you can continue with the following:

- Ansible is use to run automated tasks from host preparation to service deployment.
- Docker is use to contain services which will get deployed by Ansible.
- Combining two of above together created infrastructure as a code, which is a way to do and maintain infrastructure with codes that is easier to maintain and understand.


Requirements
----------------------------------------------------------
- Docker 1.10 or above.
- Docker machine 0.7.0 or above.
- Ansible 2.1 (with patch) or above.
- Able to SSH to host.

Let's get started
----------------------------------------------------------
- [Getting Started: The start line](docs/tutorial/01_getting_started.md)
- [Inventories, Files, Variables]()

Roles List
----------------------------------------------------------
- [Host Preparation.]()
- [Install Docker.]()
- [Manage docker machine.]()
- [Automated Docker.]()

Structure
==========================================================
Playbook. <br>
Roles. <br>
Files. <br>
Group_vars. <br>
Picture incoming.

FAQ
----------------------------------------------------------
###Variable priority
According to [Variable Precedence: Where Should I Put A Variable?](http://docs.ansible.com/ansible/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable). TL;DR 'The last listed variables win'.
Order of variable priority would be:

- roles/*/default/main.yml
- group_vars/all
- group\_vars/group_name
- host_vars/all
- host\_vars/group_name
- vars/\*.yml (as specific vars_file in inventory file)
- extra vars with -e with `ansible-playbook` command

So from above priority. In use case you want to specific something like the memory of elastic search and will be difference on each cluster. You should create default allocate memory variable in `group_vars/all` file and specific memory for each cluster in `group_vars/group_name`. Don't forget to change group_name file name to your group name. And don't forget to remove or comment that variable in `vars/*.yml` since it will overwrite and win the priority.

License
----------------------------------------------------------
The MIT License (MIT)
