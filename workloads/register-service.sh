#!/bin/bash
while true; do
  echo -n "register service ... "
  curl --request PUT --data @payload.json -H Host:consul-dev.mwlabs.net http://10.10.10.10:8500/v1/catalog/register
  sleep 30
done
