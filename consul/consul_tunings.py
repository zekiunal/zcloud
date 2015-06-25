__author__ = 'ali'

# pip install python-consul
import consul

# consul client localhost on default port 8500
consul_client = consul.Consul()

# pip install python-etcd
import etcd
# etcd client localhost on default port 40001
etcd_client = etcd.Client

# health check definitions.
#
# From consul documentation, https://www.consul.io/docs/agent/http/agent.html#agent_check_register:
#
#
# The register endpoint expects a JSON request body to be PUT. The request body must look like:
#
# {
#   "ID": "mem",
#   "Name": "Memory utilization",
#   "Notes": "Ensure we don't oversubscribe memory",
#   "Script": "/usr/local/bin/check_mem.py",
#   "HTTP": "http://example.com",
#   "Interval": "10s",
#   "TTL": "15s"
# }
#
# The Name field is mandatory, as is one of Script, HTTP or TTL. Script and HTTP also require that Interval be set.
#
# If an ID is not provided, it is set to Name. You cannot have duplicate ID entries per agent, so it may be necessary
# to provide an ID.
#
# The Notes field is not used internally by Consul and is meant to be human-readable.
#
# If a Script is provided, the check type is a script, and Consul will evaluate the script every Interval to update
# the status.
#
# An HTTP check will perform an HTTP GET request against the value of HTTP (expected to be a URL) every Interval. If
# the response is any 2xx code, the check is passing. If the response is 429 Too Many Requests, the check is warning.
# Otherwise, the check is critical.
#
# If a TTL type is used, then the TTL update endpoint must be used periodically to update the state of the check.
#
# Optionally, a ServiceID can be provided to associate the registered check with an existing service provided by the
# agent.
#
# This endpoint supports ACL tokens. If the query string includes a ?token=<token-id>, the registration will use the
# provided token to authorize the request. The token is also persisted in the agent's local configuration to enable
# periodic anti-entropy syncs and seamless agent restarts.
#
# The return code is 200 on success.


REDIS_HEALTH_CHECK = '{"Script": "curl zetaops.io", "Interval": "300s"}'
RIAK_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}
PGSQL_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}
ZATO_SERVER_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}
ZATO_WEBADMIN_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}
HAPROXY_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}
APP_HEALTH_CHECK = {"Script": "curl zetaops.io", "Interval": "20s"}


# health check
def insert_health_check(hc_service_name):
    # if hc_service_name is None, nothing to do
    if hc_service_name is None:
        return False

    if hc_service_name is 'redis':
        pass
    elif hc_service_name is 'riak':
        pass

# get list of all service's names
all_service_list = consul_client.catalog.services()[1]

for service_name in all_service_list:
    # ignore consul services
    if not service_name.startswith('consul'):
        # get list of all services named service_name
        service_list = consul_client.catalog.service(service_name)[1]
        for service in service_list:
            # service contains:
            # {
            #     u'Node': u'redis-t.c.zetaops-academic-erp.internal',
            #     u'ServiceName': u'redis', u'ServicePort': 49153,
            #     u'ServiceID': u'redis-t.c.zetaops-academic-erp.internal:redis_t:6379',
            #     u'ServiceAddress': u'172.17.0.9',
            #     u'Address': u'10.240.194.118',
            #     u'ServiceTags': None
            # }
            insert_health_check(service['ServiceName'])
