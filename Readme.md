# Paloschi Sistemas - Oficial docker image for Odoo 17

How do use this docker image ?
---------------------

tldr; Minimal command to run this image

```bash
▶ docker run --name odoo --net host -d -e PG_USER=odoo -e PG_PASSWORD=odoo paloschisistemas/docker-odoo:17.0
```

Other parameters:

* PG_HOST=localhost
* PG_PORT=5432
* PG_USER=odoo
* PG_PASSWORD=odoo
* PORT=8069
* LONGPOLLING_PORT=8072
* WORKERS=3
* ODOO_PASSWORD=senha_admin
* DISABLE_LOGFILE=0
* ODOO_ENTERPRISE=1
* TRUSTCODE_ENTERPRISE=1
* ODOO_VERSION=14.0

Example: Switching the port on which Odoo will listen to:

```bash
▶ docker run --name odoo --net host -d -e PG_USER=odoo -e PG_PASSWORD=odoo -e PORT=8050 paloschisistemas/docker-odoo:17.0
```

Preferred way:
---------------------

Install [docker-compose](https://docs.docker.com/compose/install/) to manage docker containers.

Create a docker-compose file following this example:
```yaml
version: '3'
services:
  odoo-update:
    image: paloschisistemas/docker-odoo:17.0
    network_mode: host
    volumes:
      - ~/.ssh:/home/temp/.ssh
      - ~/dados:/opt/dados
    environment:
      PG_USER: postgres_user
      PG_PASSWORD: 123
      ODOO_VERSION: 17.0
      DATABASE: database
      DISABLE_LOGFILE: 1
      TIME_CPU: 600
      TIME_REAL: 720
```

Parameters:

- DATABASE - optional database name (required if you use autoupdate command when run the image)
- DISABLE_LOGFILE - disable odoo logs to a file, instead output to standard (useful with autoupdate)
- TIME_CPU - cpu limit before timeout
- TIME_REAL - real limit before timeout

Change the parameters as you want and run:
```bash
▶ docker-compose up
```

Updating the Odoo instance
----------------------------------

Download the latest version of this docker image and follow below. We run daily builds of this image, it's safer to run this process in your Odoo instance at same periodicity.

If you want to update your Odoo instance just add to your docker-compose file the following command:
```yaml
    image: paloschisistemas/docker-odoo:17.0
    command: autoupdate
    network_mode: host
```
But before run this you should install the module "module_auto_update", without the module installed in the database the above command will not update Odoo (still not available for version 17). More info on the [module](https://github.com/OCA/server-tools/tree/16.0/module_auto_update).


Using for development and testing:
-----------------------------------

Download this repository, change the environment variables in docker-compose.yml and run:
```bash
▶ docker-compose build && docker-compose up
```

Paloschi Sistemas
----------------
