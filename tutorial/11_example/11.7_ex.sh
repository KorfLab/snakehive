#!/bin/bash

declare -a jid
num_trials=5
script="run_file.slurm"

for ((num=1; num<=num_trials; num++)); do
    if [ $num -eq 1 ]; then
        jid[$num]=$(sbatch --parsable $script)
    else
        jid[$num]=$(sbatch --parsable \
        --dependency=afterany:${jid[$((num-1))]} $script)
    fi
done