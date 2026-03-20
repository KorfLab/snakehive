#!/bin/bash
#SBATCH --job-name=get_mem
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%x/get_mem.out
#SBATCH --err=jobs/%x/get_mem.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=5MB
#SBATCH --time=5:00


printf "This is the conda environment test" > mem_used.txt
printf "JobID\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_envs; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,MaxRSS,State --noheader >> mem_used.txt
done

printf "This is the workflow test" >> mem_used.txt
printf "JobID\tMaxRSS\tState\n" >> mem_used.txt
for file in jobs/*_wkflow; do
    jobid=${file#*/}
    jobid=${jobid%_*}
    echo $jobid
    sacct -j $jobid --format=JobID,MaxRSS,State --noheader >> mem_used.txt
done