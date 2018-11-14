#!/bin/bash

CONFIG_FILE='./main.conf'
FIRST_STAGE='0'
LAST_STAGE='4'

if [ "${UID}" -ne 0 ]; then
    printf "%s\n" "User must be root" 2>&1-
fi

. "${CONFIG_FILE}"

for stage in $(seq "${FIRST_STAGE}" "${LAST_STAGE}"); do
    printf "%s\n" "Stage ${stage}"
    . ./stage_${stage}.sh
done
