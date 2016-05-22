Install Docker Compose playbook
---------------------------------------------------------------------------

- See sample variable file at ```vars/docker_compose.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/docker_compose.example```. Copy and reconfigure to make your own inventory file especially ```docker_compose_vars_file``` variable that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/docker_compose/

```bash
# Install galaxy role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.docker_compose

# Run playbook
ansible-playbook -i inventories/docker_compose --ask-become-pass \
install-docker-compose.yml
```
