Main structure
==========================================================
![Structure](/docs/pics/ansible-structure.png)

Structure is set with 3 tiers:

- **Configuration tier:** Included Inventories, Files, and Variables. Playbook with read from this tier for target remote host(s), required files for service, and required variables. See [Inventories, Files, Variables](/docs/refs/configuration.md) for detailed information.
- **Playbook tier:** Each playbook will run a role.
- **Role tier:** Each ansible role will have tasks of their own which needed to perform to complete designated task.

Top-level structure
----------------------------------------------------------
    .
    ├── files                         # Static files to be copied to service while deploying
    ├── group_vars                    # Variables to configure deployment
    ├── inventories                   # Target hosts
    ├── roles                         # Roles downloaded from Ansible Galaxy
    └── [PLAYBOOK].yml                # Playbook files

Configuration tier structure
----------------------------------------------------------
### Inventories
> Inventories are files that define target remote hosts. Use when running a playbook.

    .
    └── inventories                   # Inventories path
        └── [INVENTORY_FILE]          # Inventory file

### Files
> Files are static files that will be copy to service while deploying.

    .
    ├── files                       # files path
        ├── groups
            └── [GROUP_NAME]        # Group name (Refer to inventory file)
                ├── [FILES]         # Files to use
                └── [FILES]
        └── docker-machine          # Appear after you've run manage-docker-machine.yml
            ├── certs               # Certificate of docker machine
            └── machines            # List of machine

### Variables
> Variables are simply configurations for Ansible docker.

    .
    ├── group_vars                  # Variables path
        ├── [GROUP_NAME]            # Variables group name (Refer to inventory file)
            └── [ROLE_NAME]         # Role name (Refer to 4 main roles)
                ├── [FILES].yml     # Variables file
                └── [FILES].yml

Playbooks tier structure
----------------------------------------------------------
> Playbooks are main file that will be run by Ansible and call role to execute tasks.

    .
    ├── [PLAYBOOK].yml              # Playbook file
    ├── [...]
    └── [PLAYBOOK].yml

Roles tier structure
----------------------------------------------------------
> Roles are set of tasks written to organize Ansible. Can be found and downloaded at Ansible Galaxy.

    .
    ├── roles                       # Roles path
        └── [ROLE_NAME]             # Role name (Refer to 4 main roles)
            ├── defaults            # Default variables of the role
            ├── files               # Default files of the role
            ├── handlers            # Role handlers to be called
            ├── meta                # Ansible Galaxy metadata
            ├── tasks               # All tasks of the role
            ├── templates           # Templates file of the role
            ├── tests               # For Travis tests
            └── vars                # Service's specific variables
