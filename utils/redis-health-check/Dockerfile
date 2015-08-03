FROM python:2-slim
RUN pip install redis
ADD ./redis-ping.py /opt/redis-ping.py
RUN chmod 755 /opt/redis-ping.py
CMD ["python", "/opt/redis-ping.py"]

