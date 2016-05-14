Install Docker playbook
---------------------------------------------------------------------------

- See sample variable file at ```vars/install_docker.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/install_docker.yml.example```. Copy and reconfigure to make your own inventory file especially ```install_docker_vars_file``` variable that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/install_docker/

```bash
# Install galaxy role include all dependencies. Use --force to force update to latest
ansible-galaxy install --force winggundamth.install_docker

# Run playbook
ansible-playbook -i inventories/install_docker install_docker.yml
```
