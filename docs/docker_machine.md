Manage Docker Machine playbook
---------------------------------------------------------------------------

- See sample variable file at ```vars/docker_machine.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/docker_machine.example```. Copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file``` variable that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/docker_machine/

```bash
# Install galaxy role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.docker_machine

# Run playbook
ansible-playbook -i inventories/docker_machine manage-docker-machine.yml

# You may need --ask-become-pass if you set install_docker_machine is true
ansible-playbook -i inventories/docker_machine --ask-become-pass \
manage-docker-machine.yml

# To search and replace docker machine config.json configuration file only
ansible-playbook -i inventories/docker_machine \
--extra-var docker_machine_manage_config=true \
--tag docker-machine-manage-config manage-docker-machine.yml
```
