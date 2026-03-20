#!/bin/bash

printf "This is the conda environment test\n" > mem_used.txt
printf "JobID\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_envs; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,MaxRSS,State --noheader >> mem_used.txt
done

printf "This is the workflow test\n" >> mem_used.txt
printf "JobID\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_wkflow; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,MaxRSS,State --noheader >> mem_used.txt
done