#! /bin/sh
# from hectorcasto, modified by aliriza@zetaops.io
# IP_ADDRESS, STRONG_CONSISTENCY, RIAK_CONTROL values are injected by docker run command

# Ensure correct ownership and permissions on volumes
chown riak:riak /var/lib/riak /var/log/riak
chmod 755 /var/lib/riak /var/log/riak

# Open file descriptor limit
ulimit -n 65536

# Ensure the Erlang node name is set correctly
sed -i.bak "s/riak@127.0.0.1/riak@${IP_ADDRESS}/" /etc/riak/riak.conf

# set strong consistency and riak_control on or off depends on docker run env vars
sed -i.bak "s/strong_consistency = off/strong_consistency = ${STRONG_CONSISTENCY}/" /etc/riak/riak.conf
sed -i.bak "s/riak_control = off/riak_control = ${RIAK_CONTROL}/" /etc/riak/riak.conf


# Start Riak
exec /sbin/setuser riak "$(ls -d /usr/lib/riak/erts*)/bin/run_erl" "/tmp/riak" \
   "/var/log/riak" "exec /usr/sbin/riak console"

