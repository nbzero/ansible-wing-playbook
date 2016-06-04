Manage docker registry container playbook
---------------------------------------------------------------------------

- This role will use 2 roles configuration. If you already used [winggundamth.docker_machine](docker_machine.md) to prepare docker-machine so you can just config this role and run it. But if not, you need to prepare [winggundamth.docker_machine](docker_machine.md) configuration.
- You have to create directory that normally at ```files/groups/{{ group_names[-1] }}/docker-registry/``` as a trigger for remote machine group to run this role.
- Put ```config.yml``` file in directory above. You can see syntax here https://github.com/docker/distribution/blob/master/docs/configuration.md or you can config this via environment variables that will be in vars file in next bullet
- See sample variable file at ```vars/docker_registry_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/docker_registry_container.example```. You can use the same inventory file from [winggundamth.docker_machine](docker_machine.md) but you have to put ```docker_registry_container_vars_file``` variable. Otherwise you have to copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file``` and ```docker_registry_container_vars_file``` variables that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/docker_registry_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.docker_registry_container

# Run playbook
ansible-playbook -i inventories/docker_registry_container docker_registry-container.yml
```
