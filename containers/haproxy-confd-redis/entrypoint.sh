#!/bin/bash
set -e
exec gosu root confd -backend etcd -node $ETCD_IP:4001
