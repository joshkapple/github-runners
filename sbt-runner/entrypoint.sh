#!/bin/bash

CREDENTIALS=./creds/.credentials
CREDENTIALS2=./creds/.credentials_rsaparams
RUNNER=./creds/.runner

if [[ -f $CREDENTIALS ]] && [[ -f $CREDENTIALS2 ]] && [[ -f $RUNNER ]]; then
  echo "runtime credentials found, copying"
  cp $CREDENTIALS .
  cp $CREDENTIALS2 .
  cp $RUNNER .
else
  echo "Runtime credentials not found, running config"
  if [[ -z $URL || -z $TOKEN ]]; then
    echo 'Environment variables for $URL and/or $TOKEN have not been set.'
    exit 1
  else
    ./config.sh --url $URL --token $TOKEN
    cp .credentials $CREDENTIALS
    cp .credentials_rsaparams $CREDENTIALS2
    cp .runner $RUNNER
  fi
fi

$@