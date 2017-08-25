function pgstart () {
    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
}

function pgstop () {
    pg_ctl -D /usr/local/var/postgres stop
}

function pgstatus () {
    pg_ctl -D /usr/local/var/postgres status
}

function pghardreset () {
    rm -rf /usr/local/var/postgres && initdb /usr/local/var/postgres -E utf8
}


