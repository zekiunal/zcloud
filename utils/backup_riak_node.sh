#!/bin/bash
# a simple riak backup script

# first stop node
echo "riak service shutting down.."
sudo service riak stop
sleep 1
echo "riak service is down..."

# second prepare  date based backupdir
DATE=`date +%Y%m%d_%H%M`
BACKUPDIR="/mnt/backup/riak/$DATE"
sudo mkdir -p $BACKUPDIR

# third compress all data dirs into backup dir
echo "data directories are being compressed and copied ..."
echo "this can take a few minutes up to your data amount."
echo "please some patience and wait..."

sudo tar -czf $BACKUPDIR/riak_data_ensembles_$DATE.tar.gz /var/lib/riak/ensembles
sudo tar -czf $BACKUPDIR/riak_data_ring_$DATE.tar.gz /var/lib/riak/ring
sudo tar -czf $BACKUPDIR/riak_data_yz_$DATE.tar.gz /var/lib/riak/yz
sudo tar -czf $BACKUPDIR/riak_data_bitcask_mult_$DATE.tar.gz /var/lib/riak/bitcask_mult
sudo tar -czf $BACKUPDIR/riak_data_anti_entropy_$DATE.tar.gz /var/lib/riak/anti_entropy
sudo tar -czf $BACKUPDIR/riak_data_cluster_meta_mult_$DATE.tar.gz /var/lib/riak/cluster_meta
sudo tar -czf $BACKUPDIR/riak_data_kv_vnode_$DATE.tar.gz /var/lib/riak/kv_vnode
sudo tar -czf $BACKUPDIR/riak_data_leveldb_mult_$DATE.tar.gz /var/lib/riak/leveldb_mult
sudo tar -czf $BACKUPDIR/riak_data_yz_anti_entropy_$DATE.tar.gz /var/lib/riak/yz_anti_entropy

echo "all data directories have been copied into $BACKUPDIR"

# lastly start riak service up back
echo "riak service starting up.."
sudo service riak start
echo "done"
