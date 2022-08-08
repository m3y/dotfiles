#!/bin/sh

AQUA_FILE=""
if [ -f ./aqua.yaml ]; then
    AQUA_FILE="./aqua.yaml"
else
    AQUA_FILE="${HOME}/.config/aquaproj-aqua/aqua.yaml"
fi

cat ${AQUA_FILE} | yq '.packages[].name' | grep terraform | awk -F@ '{print $2}'
