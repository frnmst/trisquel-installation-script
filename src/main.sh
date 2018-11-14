#!/bin/bash

. ./main.conf

for stage in $(seq 0 4); do
    printf "%s\n" "Stage ${stage}"
    . ./stage_${stage}.sh
done
