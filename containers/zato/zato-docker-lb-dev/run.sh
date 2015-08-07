# zato create load balancer config
ca_certs_path=/opt/zato/ca/ca_cert.pem
cert_path=/opt/zato/ca/zato.load_balancer.cert.pem
command=create_lb
path=/opt/zato/env/load-balancer
priv_key_path=/opt/zato/ca/zato.load_balancer.key.pem
pub_key_path=/opt/zato/ca/zato.load_balancer.key.pub.pem
store_config=False



RUN /opt/zato/zato_from_config_create_load_balancer
RUN sed -i 's/127.0.0.1:11223/0.0.0.0:11223/g' /opt/zato/env/load-balancer/config/repo/zato.config
RUN sed -i 's/localhost/0.0.0.0/g' /opt/zato/env/load-balancer/config/repo/lb-agent.conf

CMD ["/opt/zato/zato_start_load_balancer"]
