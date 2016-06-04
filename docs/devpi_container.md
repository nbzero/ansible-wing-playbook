Manage devpi container playbook
---------------------------------------------------------------------------

- This role will use 2 roles configuration. If you already used [winggundamth.docker_machine](docker_machine.md) to prepare docker-machine so you can just config this role and run it. But if not, you need to prepare [winggundamth.docker_machine](docker_machine.md) configuration.
- You have to create directory that normally at ```files/groups/{{ group_names[-1] }}/devpi/``` as a trigger for remote machine group to run this role.
- See sample variable file at ```vars/devpi_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/devpi_container.example```. You can use the same inventory file from [winggundamth.docker_machine](docker_machine.md) but you have to put ```devpi_container_vars_file``` variable. Otherwise you have to copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file``` and ```devpi_container_vars_file``` variables that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/devpi_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.devpi_container

# Run playbook
ansible-playbook -i inventories/devpi_container devpi-container.yml
```
