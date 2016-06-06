New Relic playbook
---------------------------------------------------------------------------

- See sample variable file at ```vars/newrelic.yml.example```. Copy and reconfigure to make your own variable file
- See sample inventory file at ```inventories/newrelic.example```. Copy and reconfigure to make your own inventory file especially ```newrelic_vars_file``` variable that you have to change to your variable file
- More info about this role at https://galaxy.ansible.com/winggundamth/newrelic/

```bash
# Install galaxy role. Use --force to force update to latest
ansible-galaxy install --force winggundamth.newrelic

# Run playbook
ansible-playbook -i inventories/newrelic newrelic.yml
```
