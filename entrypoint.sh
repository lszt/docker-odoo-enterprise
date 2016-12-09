#!/bin/bash

set -e

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${PGHOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PGPORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${PGUSER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PGPASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

DB_ARGS=()
function check_config() {
    param="$1"
    value="$2"
    if ! grep -q -E "^\s*\b${param}\b\s*=" "$OPENERP_SERVER" ; then
        DB_ARGS+=("--${param}")
        DB_ARGS+=("${value}")
   fi;
}
check_config "db_host" "$PGHOST"
check_config "db_port" "$PGPORT"
check_config "db_user" "$PGUSER"
check_config "db_password" "$PGPASSWORD"

case "$1" in
    -- | openerp-server)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec openerp-server "$@"
        else
            exec openerp-server "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        exec openerp-server "$@" "${DB_ARGS[@]}"
        ;;
    *)
        exec "$@"
esac

exit 1
