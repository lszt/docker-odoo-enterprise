#!/bin/sh
docker pull odoo:9.0
docker build -t odoo-enterprise .
