#!/bin/bash

host=$1
key_base=$2
epoch=$(date "+%s")
value=$(expr $(od -vAn -N4 -tu4 < /dev/random) % 60)

echo $epoch
echo $value

redis-cli -h $host --eval insert_into_buckets.redis.lua $key_base , $epoch $value
