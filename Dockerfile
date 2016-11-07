FROM babim/alpinebase

ENV LANG en_US.utf8

RUN apk add --no-cache postgresql postgresql-client postgresql-contrib wget && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" --no-check-certificate && \
    chmod +x /usr/local/bin/gosu && \
    mkdir -p /docker-entrypoint-initdb.d && apk del wget

VOLUME /var/lib/postgresql/data

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
