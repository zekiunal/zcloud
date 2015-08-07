import riak
from loremipsum import generate_paragraph
import random
import string

client = riak.RiakClient(protocol='pbc', host='zx-riak-01.c.zetaops-academic-erp.internal', http_port=8087)

mybucket = client.bucket_type('sc').bucket('buket')

for i in range(1, 1000):
    dd = '{"%s":"%s", "%s":"%s"}' % ("".join(random.choice(string.letters) for i in range(random.randint(3, 15))),
                                     "".join(random.choice(string.letters) for i in range(random.randint(300, 1000))),
                                     "".join(random.choice(string.letters) for i in range(random.randint(3, 15))),
                                     generate_paragraph())
    mybucket.new(data=dd).store()

