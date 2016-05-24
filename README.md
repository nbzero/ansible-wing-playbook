Ansible Wing Playbook
===========================================================================

This is all my playbook with example configuration and commands.

Pre-requisites
---------------------------------------------------------------------------

- Ansible 2.0+ (Some roles maybe need 2.1. Please read README.md in each role again)

How to Use
---------------------------------------------------------------------------

- Fork this repository and make your own configuration from example files
- You shouldn't have to edit any file in this repository. This make you easier to maintain and update playbook from upstream
- If you find yourself that you have to edit any file in this repository so it means that you have to send that pull request to me :P
- To update playbook from upstream. Run below commands

```bash
# http://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository
# Add the remote, call it "upstream":
git remote add upstream https://github.com/winggundamth/ansible-wing-playbook.git

# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:
git fetch upstream

# Merge upstream/master to your forked repository
git merge upstream/master
```

Playbooks list
---------------------------------------------------------------------------

- [Host preparation](docs/host_preparation.md)
- [Install Docker](docs/install_docker.md)
- [Manage Docker Machine](docs/docker_machine.md)
- [Manage nginx container](docs/nginx_container.md)
- [Install Docker Compose](docs/docker_compose.md)
- [Run apt-cacher-ng container](docs/apt_cacher_ng_container.md)
