#!/bin/sh

set -e
  
host="$1"
shift
cmd="$@"
  
until mysql -h "$host" -u "root" -P "3306" -ppassword -e 'show databases;'; do
  >&2 echo "mysql is unavailable - sleeping"
  sleep 1
done
  
>&2 echo "mysql is up - executing command"
exec $cmd


