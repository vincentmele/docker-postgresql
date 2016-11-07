FROM babim/alpinebase:ssh

ENV LANG en_US.utf8

RUN apk add --no-cache postgresql postgresql-client postgresql-contrib \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64.asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    mkdir -p /docker-entrypoint-initdb.d

VOLUME /var/lib/postgresql/data

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432 22
CMD ["postgres"]
