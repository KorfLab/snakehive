#!/bin/bash
for rule in jobs/rule*; do
    jobids=${$rule/*}
    printf "%s has these jobids %s" "${rule#*/}" "$jobids"
done