#!/bin/sh
(cd odoo && git pull)
(cd enterprise && git pull)
docker pull odoo:9.0
docker build -t odoo-enterprise .
