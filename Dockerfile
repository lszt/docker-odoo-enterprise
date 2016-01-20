FROM odoo:9.0
MAINTAINER Philipp Hug <philipp@hug.cx>

# Set user back to root
USER root

ADD odoo /opt/odoo
ADD enterprise /opt/odoo-enterprise

# remove web plugin
RUN rm -Rf /opt/odoo/addons/web

COPY ./openerp-server /usr/bin/openerp-server
RUN chmod +x /usr/bin/openerp-server
RUN chown odoo /usr/bin/openerp-server

COPY ./openerp-server.conf /etc/odoo/
#RUN chown odoo /etc/odoo/openerp-server.conf

# Set default user when running the container
USER odoo

