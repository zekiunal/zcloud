FROM nginx
ENV UI_BRANCH master
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD [""]
ENTRYPOINT["/entrypoint.sh"]

