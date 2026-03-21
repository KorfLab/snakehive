#!/bin/bash
#SBATCH --job-name=get_mem
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=5MB
#SBATCH --time=3:00

printf "This is the conda environment test\n" > mem_used.txt
printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_envs; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done

printf "This is the workflow test\n" >> mem_used.txt
printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_wkflow; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done

printf "This is the rules test\n" >> mem_used.txt
printf "JobID\tReqMem\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/rule*/*; do
    jobid=${file#*/}
    jobid=${jobid#*/}
    jobid=${jobid%.*}
    echo $jobid
    sacct -j $jobid --format=JobID,ReqMem,MaxRSS,State --noheader >> mem_used.txt
done