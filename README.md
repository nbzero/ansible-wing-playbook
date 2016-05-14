Ansible Wing Playbook
===========================================================================

This is all my playbook with example configuration and commands.

Pre-requisites
---------------------------------------------------------------------------

- Ansible 2.0+

Host preparation playbook
---------------------------------------------------------------------------

- Prepare authorized_keys at ```files/authorized_keys```
- See sample variable file at ```vars/host_preparation.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/host_preparation.example```. Copy and reconfigure to make your own inventory file especially ```host_preparation_vars_file``` variable that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/host_preparation/

```bash
# Install galaxy role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.host_preparation

# Run playbook
# To use --ask-pass and --ask-become-pass you may need to install sshpass
sudo apt-get install sshpass
ansible-playbook -i inventories/host_preparation \
--ask-pass --ask-become-pass host-preparation.yml
# Put ssh password for target hosts

# Run only host-preparation-update-packages tag with limited target hosts
# on group prod and db
ansible-playbook -i inventories/host_preparation \
--tag host-preparation-update-packages --limit prod:db host-preparation.yml
```
