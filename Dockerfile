FROM debian:11

RUN apt update
RUN apt install build-essential -y
RUN apt install wget libreadline-dev zlib1g-dev -y

RUN cd /opt \
    && wget https://ftp.postgresql.org/pub/source/v8.4.7/postgresql-8.4.7.tar.gz \
    && tar -xvf postgresql-8.4.7.tar.gz \
    && rm postgresql-8.4.7.tar.gz

RUN cd /opt/postgresql-8.4.7 \
    && export CFLAGS=-fno-aggressive-loop-optimizations \
    && ./configure \
    && make -j4 \
    && make install

RUN useradd -m postgres \
    && mkdir /usr/local/pgsql/data \
    && chown postgres /usr/local/pgsql/data

RUN echo "postgres" > /usr/local/pgsql/share/password.txt \
    && echo "host  all all 0.0.0.0/0 md5" >> /usr/local/pgsql/share/pg_hba.conf.sample \
    && echo "listen_addresses = '*'" >> /usr/local/pgsql/share/postgresql.conf.sample

COPY docker-entrypoint.sh /home/postgres/docker-entrypoint.sh

EXPOSE 5432
CMD ["sh", "-e", "/home/postgres/docker-entrypoint.sh"]
