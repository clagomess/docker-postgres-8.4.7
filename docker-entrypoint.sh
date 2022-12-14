#/bin/bash

[ "$(ls -A /usr/local/pgsql/data)" ] && echo "Not Empty" || /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data -A md5 --pwfile=/usr/local/pgsql/share/password.txt
/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data