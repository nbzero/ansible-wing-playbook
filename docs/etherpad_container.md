Manage gitlab container playbook
---------------------------------------------------------------------------

- This role will combine 2 roles configuration together.
  - [winggundamth.mariadb_container](mariadb_container.md)
  - [winggundamth.gitlab_container](gitlab_container.md)
- If you are not deploy on localhost. You need to use [winggundamth.docker_machine](docker_machine.md) to prepare target host with docker-machine first. And this role will use the same configuration to manage container on target host.
- You have to create directory that normally at ```files/groups/{{ group_names[-1] }}/gitlab/``` as a trigger for remote machine group to run this role.
- See sample variable file at ```vars/gitlab_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/gitlab_container.example```. You can use the same inventory file from [winggundamth.docker_machine](docker_machine.md) but you have to put ```gitlab_container_vars_file``` variable. Otherwise you have to copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file```, ```postgresql_container_vars_file``` and ```redis_container_vars_file``` variables that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/gitlab_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.gitlab_container

# Run playbook
ansible-playbook -i inventories/gitlab_container gitlab-container.yml
```
