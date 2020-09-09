#!/bin/bash

PUBLISH_ROOT="/gevol/server/published_dbs"

# Configure publish root
/opt/google/bin/geconfigurepublishroot --noprompt --path=$PUBLISH_ROOT

# Select publish root
/opt/google/bin/geselectpublishroot $PUBLISH_ROOT

# Run server
/etc/init.d/geserver start

# Stop postgres service
sudo -u gepguser ./pg_ctl -D /var/opt/google/pgsql/data/ stop

# Tunnel postgres socket
ssh -L /tmp/.s.PGSQL.5432:/var/run/postgresql/.s.PGSQL.5432 $IP

# Stay alive
while true; do sleep 3; done
