#!/bin/sh
cd $(dirname $0)
while :
do
  bundle exec ruby result.rb
  sleep 18000
done
