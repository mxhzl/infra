# infra

Repo for storing the Terraform/Ansible files for my server needs.

Required environment variables:
`TF_VAR_b2_application_key`
`TF_VAR_b2_application_key_id`
`TF_VAR_do_token`
`VAULT_PASSWORD`
`TF_VAR_porkbun_api_key`
`TF_VAR_porkbun_secret_api_key`

```sh
$ mise install
$ cd tofu
$ tofu init
$ tofu plan|apply
```

After running terraform, you will have to set up [permissions](https://docs.digitalocean.com/products/databases/postgresql/how-to/modify-user-privileges/) for all the database users that were created, and set them as owners of their respective databases. Get the connection info from digital ocean's dashboard.

```sql
\connect dbname
GRANT ALL ON DATABASE dbname TO user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO user;
ALTER ROLE user CREATEDB;
ALTER ROLE user LOGIN;
ALTER ROLE user REPLICATION;
ALTER ROLE user BYPASSRLS;
ALTER DATABASE dbname OWNER TO user;
```

Make sure to update the ansible vault file with db connection details from digital ocean.

```sh
$ cd ../ansible
$ ansible-playbook provisioning.yml -u root -i hosts
$ ansible-playbook <playbook-name>.yml -i hosts
```

Reminder that you will need to manually create your users in your various apps.

```sh
$ ssh username@serverip
$ forgejo admin user create --username admin --random-password --access-token --admin --email test@example.com
$ docker compose exec linkding python manage.py createsuperuser --username=admin --email=test@example.com
$ docker compose exec mind_electric bin/rails c
> user = User.new(email: "test@example.com", password: "admin", password_confirmation: "admin")
> user.save
> user.confirm
```
