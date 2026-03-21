#!/bin/bash

printf "This is the conda environment test\n" > mem_used.txt
printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_envs; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done
echo

printf "This is the workflow test\n" >> mem_used.txt
printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_wkflow; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done
echo

printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/rule*/*; do
    jobid=${file#*/}
    jobid=${jobid#*/}
    jobid=${jobid%.*}
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done