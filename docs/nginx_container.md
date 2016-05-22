Manage nginx container playbook
---------------------------------------------------------------------------

- This role will use 2 roles configuration. If you already used [winggundamth.docker_machine](docker_machine.md) to prepare docker-machine so you can just config this role and run it. But if not, you need to prepare [winggundamth.docker_machine](docker_machine.md) configuration.
- See sample nginx configuration file at ```files/host/host-01.example.com/nginx/*```. Copy and reconfigure to make your own nginx configuration files. The structure would be
  - ```files/host/{{ inventory_hostname }}/nginx/config/*``` for normal nginx configuration files and you must have at least ```nginx.conf``` file inside since it will be the first config file that nginx container will read. This will normally copy to ```/etc/nginx/``` directory.
  - ```files/host/{{ inventory_hostname }}/nginx/encrypt/*``` for all encrypt nginx configuration files such as ssl certification. This will encrypt with ```ansible-vault encrypt``` command and you have to put your vault file at ```.vault_pass``` at the root of this repository. There already has dummy file there. This will normally copy to ```/etc/nginx/``` directory.
- See sample variable file at ```vars/nginx_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/nginx_container.example```. You can use the same inventory file from [winggundamth.docker_machine](docker_machine.md) but you have to put ```nginx_container_vars_file``` variable. Otherwise you have to copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file``` and ```nginx_container_vars_file``` variables that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/nginx_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.nginx_container

# Run playbook
ansible-playbook -i inventories/nginx_container nginx-container.yml
```
