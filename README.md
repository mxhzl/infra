# infra

Repo for storing the Terraform/Ansible files for my server needs.

```sh
$ mise install
$ cd terraform
$ terraform login
$ terraform apply -var "do_token=$DO_PAT"
$ cd ../ansible
$ ansible-playbook provisioning.yml -u root -i hosts
$ ansible-playbook <playbook-name>.yml -i hosts
````
