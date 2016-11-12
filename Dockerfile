FROM babim/alpinebase:cron.ssh

ENV PGDATA /var/lib/postgresql \
    LANG en_US.utf8 \
    BACKUP_PATH /backup

ENV GOSU_VERSION 1.9
RUN set -x && \
    apk add --no-cache postgresql postgresql-client postgresql-contrib wget && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" --no-check-certificate && \
    chmod +x /usr/local/bin/gosu && \
    mkdir -p /docker-entrypoint-initdb.d && apk del wget

VOLUME ["${PGDATA}", "${BACKUP_PATH}"]

COPY entrypoint.sh /entrypoint.sh
COPY backup.sh /backup.sh
RUN chmod 755 /*.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432 22
CMD ["postgres"]
