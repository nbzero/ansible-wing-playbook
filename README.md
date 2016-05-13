Ansible Wing Playbook
===========================================================================

This is all my playbook with example configuration and commands.

Pre-requisites
---------------------------------------------------------------------------

- Ansible 2.0+

Host preparation playbook
---------------------------------------------------------------------------

- Prepare authorized_keys at ```files/authorized_keys```
- See sample inventory file at ```inventories/host_preparation.example```

```bash
# Install galaxy role
ansible-galaxy install winggundamth.host_preparation

# Run playbook
# To use --ask-pass and --ask-become-pass you may need to install sshpass
sudo apt-get install sshpass
ansible-playbook -i inventories/host_preparation \
--ask-pass --ask-become-pass host-preparation.yml
# Put ssh password for target hosts

# Run only update-packages tag with limited target hosts on group prod and db
ansible-playbook -i inventories/host_preparation \
--tag update-packages --limit prod:db host-preparation.yml
```
