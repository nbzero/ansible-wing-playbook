Run apt-cacher-ng container playbook
---------------------------------------------------------------------------

- If you are not deploy on localhost. You need to use [winggundamth.docker_machine](docker_machine.md) to prepare target host with docker-machine first. And this role will use the same configuration to manage container on target host.
- You have to create directory that normally at ```files/groups/{{ group_names[-1] }}/apt-cacher-ng/``` as a trigger for remote machine group to run this role.
- See sample variable file at ```vars/apt_cacher_ng_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/apt_cacher_ng_container.example```. Copy and reconfigure to make your own inventory file. Don't forget to put ```docker_machine_vars_file``` in **[all:vars]** group when you are deploy on remote machine.
- More info about this role at https://galaxy.ansible.com/winggundamth/apt_cacher_ng_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.apt_cacher_ng_container

# Run playbook
ansible-playbook -i inventories/apt_cacher_ng_container apt-cacher-ng-container.yml
```
