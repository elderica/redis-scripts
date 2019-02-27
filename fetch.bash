#!/bin/bash

host=$1
key_base=$2
epoch=$(date "+%s")

redis-cli -h $host --eval fetch_from_buckets.redis.lua $key_base , $epoch
