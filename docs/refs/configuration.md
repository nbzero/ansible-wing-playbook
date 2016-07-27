Inventories, Files, Variables
=========================================================
> To put it simple, Inventories, Files, and Variables are configuration of service deployment. It's not just for services but for deployment process as well, such as docker container name for the service, port to expose, etc.

Inventories
---------------------------------------------------------
> Inventory is a file that define where your target hosts are. There can be multiple hosts in one file to deploy on multiple hosts at once.
> You can also define variables here for specific hosts.

```yml
# One host example
[mygroup-example]
ansible-01 ansible_user=ubuntu ansible_host=10.10.10.11 ansible_port=22

# Multiple hosts example
# Add automated_docker_name variable for each host
# this way they can deploy different services by running one command
[production-example]
prod-01.example.com ansible_user=ubuntu ansible_host=10.10.10.11 ansible_port=22 automated_docker_name=devpi
prod-02.example.com ansible_user=ubuntu ansible_host=10.10.10.12 ansible_port=22 automated_docker_name=mysql

[preproduction-example]
pre-01.example.com ansible_user=ubuntu ansible_host=10.10.10.21 ansible_port=22 automated_docker_name=devpi
```

Files
---------------------------------------------------------
> Files are static files for each service that need to use them, for example,
> nginx need config file to be efficiently automate deployed.
> This mean we must prepared nginx's files then copy it to nginx service after deployment.
>
> This ansible script does automate this for you, when you prepared your files properly
> Everything will be deployed with configuration files in place for each service.
> (You can check each role to see how Ansible scan for configuration files.)

.
├── files                             # files path
    ├── groups
        └── mygroup-example           # Group name (Refer to inventory file)
            ├── nginx                 # Folder for nginx service
                ├── site-available    # nginx configuration files
                ├── [...]
                └── nginx.conf
    └── docker-machine                # Appear after you've run manage-docker-machine.yml
        ├── certs                     # Certificate of docker machine
        └── machines                  # List of machine

From the example above, after nginx is deployed Ansible is set to check if there is nginx.conf or not. If there is, Ansible will copy contents in `files/groups/mygroup-example/nginx` folder to configuration folder in nginx container and load configurations from those files.

#### So, how could I know how each service scan for files?
Enter automated_docker role folder after you download it and take a look at `pre/post_start.yml` file of the service you want to know, Ansible script will tell you just that.

Variables
--------------------------------------------------------
> Variables are use to setup many things on deployment side. Ansible will read
> from variables and deploy according to them, for example, docker container name,
> docker container exposed port, docker images to use, etc.
>
> There are wide range of variables that can be set in `group_vars` folder.
> You can see all of them in role's var files. (See below for instruction.)

Example of nginx default variables in `./roles/automated_docker/vars/nginx_var.yml`
```yml
---
automated_docker_container_default:
  nginx:
    image: winggundamth/nginx:xenial
    name: nginx
    hostname: nginx
    published_ports:
      - "80:80"
      - "443:443"
```

To override default variables you need to create a file at `./group_vars/$GROUP_NAME/$ROLE_NAME/nginx.yml`

For example, `./group_vars/mygroup-example/automated_docker/nginx.yml`

```yml
---
automated_docker_container_nginx:
  nginx:
    image: winggundamth/nginx:xenial
    name: nginx-mygroup
    hostname: nginx-mygroup
    published_ports:
      - "8080:80"
      - "443:443"
```

Notice that I changed variable header from automated_docker_container_default to automated_docker_container_$SERVICE_NAME or in this case automated_docker_container_nginx.
Then I change nginx container name, hostname, and expose port 80 to 8080 instead.

After running automated_docker playbook to deploy nginx again the variables we just made will override default variables according to [Variable priority](/#variable-priority) and new nginx container will have a new name, hostname and expose different port.

#### So, how could I know what variable available for me to change?
Enter automated_docker role after you downloaded it from Ansible Galaxy, then take a look at `vars/$SERVICE_NAME_var.yml`. contents of the file is all variables you can change for that service after you put it in `group_vars`.

Also, don't forget to change `defaults` to `SERVICE_NAME` when you put it in `group_vars`
