#/bin/bash

chown -R postgres /usr/local/pgsql/data

su -c '[ "$(ls -A /usr/local/pgsql/data)" ] && echo "Not Empty" || /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data -A md5 --pwfile=/usr/local/pgsql/share/password.txt' postgres
su -c '/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data' postgres
