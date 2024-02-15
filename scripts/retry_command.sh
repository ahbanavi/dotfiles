#!/bin/bash

max_retry=10
counter=0
until "$@"; do
  sleep 5
  [[ counter -eq $max_retry ]] && echo "Failed!" && exit 1
  echo "Trying again. Try #$counter"
  ((counter++))
done

