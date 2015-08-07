import os
import sys
host = os.getenv('REDIS_HOST', 'localhost')
port = os.getenv('REDIS_PORT', '6973')
import redis
r = redis.StrictRedis(host, port)
try:
    if r.ping():
        print 'PONG'
        #sys.exit(0) # everything is ok
except:
    print 'FAIL'
    sys.exit(1) # service is not accessible 

