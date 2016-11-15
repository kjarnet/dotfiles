function pgstart () {
    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
}


function pgstatus () {
    pg_ctl -D /usr/local/var/postgres status
}


function pgstop () {
    pg_ctl -D /usr/local/var/postgres stop
}


