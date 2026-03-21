#!/bin/bash

echo "testing" > mem_used.txt
for folder in jobs/rule*; do
    rule=${folder#*/}
    jobids=($folder/*)
    printf "%s\n" "$rule" >> mem_used.txt
    printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
    for ((num=0; num<"${#jobids[@]}"; num++)); do
        jobids[$num]=${jobids[$num]##*/}
        jobids[$num]=${jobids[$num]%.log}
        echo ${jobids[$num]} >> mem_used.txt
    done
done