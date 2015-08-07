#!/bin/bash

etcdctl mkdir /zaerp/riak-servers-8087
etcdctl mkdir /zaerp/riak-servers-8098
etcdctl mkdir /zaerp/riak-servers-8043
etcdctl mkdir /zaerp/riak-servers-8093

declare -a nodes=( 1 2 3 4 5 )
declare -a ports=( 8087 8098 8043 8093 )
for i in ${nodes[@]}; do
  for p in ${ports[@]}; do
    etcdctl set /zaerp/riak-servers-$p/zx-ubuntu-riak-0$i.c.zetaops-academic-erp.internal:riak-$i:$p  zx-ubuntu-riak-0$i.c.zetaops-academic-erp.internal:$p;
  done;
done;
