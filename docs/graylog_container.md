Manage graylog container playbook
---------------------------------------------------------------------------

- This role will use 4 roles configuration.
  - [winggundamth.docker_machine](docker_machine.md)
  - [winggundamth.mongo_container](mongo_container.md)
  - [winggundamth.elasticsearch_container](elasticsearch_container.md)
  - [winggundamth.graylog_container](graylog_container.md)
- If you already used [winggundamth.docker_machine](docker_machine.md) to prepare docker-machine so you can just config this role and run it. But if not, you need to prepare [winggundamth.docker_machine](docker_machine.md) configuration.
- You have to create directory that normally at ```files/groups/{{ group_names[-1] }}/graylog/``` as a trigger for remote machine group to run this role.
- See sample variable file at ```vars/graylog_container.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/graylog_container.example```. You can use the same inventory file from [winggundamth.docker_machine](docker_machine.md) but you have to put ```graylog_container_vars_file``` variable. Otherwise you have to copy and reconfigure to make your own inventory file especially ```docker_machine_vars_file```, ```mongo_container_vars_file``` and ```elasticsearch_container_vars_file``` variables that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/graylog_container/

```bash
# Install galaxy role include dependency role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.graylog_container

# Run playbook
ansible-playbook -i inventories/graylog_container graylog-container.yml
```
