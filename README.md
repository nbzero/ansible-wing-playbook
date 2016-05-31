Ansible Wing Playbook
===========================================================================

This is all my playbook with example configuration and commands.

Pre-requisites
---------------------------------------------------------------------------

- Ansible 2.1

How to Use
---------------------------------------------------------------------------

- Fork this repository and make your own configuration from example files
- You can see all my galaxy role in ```galaxy-requirements.yml``` file. To install or update all roles, run the command

```bash
# Use -f to force reinstall roles
ansible-galaxy install -f -r galaxy-requirements.yml
```

- You shouldn't have to edit any file in this repository. This make you easier to maintain and update playbook from upstream
- If you find yourself that you have to edit any file in this repository so it means that you have to send that pull request to me :P
- To update playbook from upstream. Run below commands

```bash
# http://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository
# Add the remote, call it "upstream":
git remote add upstream https://github.com/winggundamth/ansible-wing-playbook.git

# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:
git fetch upstream

# Merge upstream/master to your forked repository
git merge upstream/master
```

Variable priority
---------------------------------------------------------------------------

According to [Variable Precedence: Where Should I Put A Variable?](http://docs.ansible.com/ansible/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable). Order of variable priority would be (The last listed variables win)

- roles/*/default/main.yml
- group_vars/all
- group_vars/group_name
- host_vars/all
- host_vars/group_name
- vars/*.yml (as specific vars_file in inventory file)
- extra vars with -e with ```ansible-playbook``` command

So from above priority. In use case you want to specific something like the memeory of elastic search and will be difference on each cluster. You should create default allocate memory variable in ```group_vars/all``` file and specific memory for each cluster in ```group_vars/group_name```. Don't forget to change *group_name* file name to your group name. And don't forget to remove or comment that variable in ```vars/*.yml``` since it will overwrite and win the priority.

Playbooks list
---------------------------------------------------------------------------

- [Host preparation](docs/host_preparation.md)
- [Install Docker](docs/install_docker.md)
- [Manage Docker Machine](docs/docker_machine.md)
- [Manage nginx container](docs/nginx_container.md)
- [Install Docker Compose](docs/docker_compose.md)
- [Run apt-cacher-ng container](docs/apt_cacher_ng_container.md)
- [Manage Mongo container](docs/mongo_container.md)
- [Manage ElasticSearch container](docs/elasticsearch_container.md)
- [Manage Graylog container](docs/graylog_container.md)
