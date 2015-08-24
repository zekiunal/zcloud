# ELK STACK FOR COREOS(JOURNALD) #

### Run ELK Container ###

- port 5000 is for syslog (UDP and TCP)
- port 5006 is for docker containers' logs (UDP)
- port 5301 is for journald logs (TCP)
- port 9200 is for elasticsearch
- port 5601 is for kibana

```bash

sudo docker run -d -p 5000:5000/udp -p 5006:5006/udp -p 5301:5301 -p 9200:9200 -p 5601:5601 --name zelk zetaops/elk
```

### Run Logspout Container ###

- This will send docker containers' logs to your elk host's 5006 port.

```bash

sudo docker run -d --name logspout --volume=/var/run/docker.sock:/tmp/docker.sock zetaops/logspout syslog://ELK_MACHINE_IP(HOSTNAME):5006
```

### Send journald logs to elk container ###

```bash

journalctl -o short -f | ncat ELK_MACHINE_IP(HOSTNAME) 5301
```

### You can directly send unit-files logs (unit-files captures stdout/stderr)###

```bash

journalctl -o short -u service_name.service -f | ncat ELK_MACHINE_IP(HOSTNAME) 5301
```

### After running logstash container type some inputs and to see results ###

For ElasticSearch

```bash
curl http://ELK_MACHINE_IP(HOSTNAME):9200/_search?pretty
```

For Kibana

```bash
http://ELK_MACHINE_IP(HOSTNAME):5601
```
