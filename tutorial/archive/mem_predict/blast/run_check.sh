#!/bin/bash

declare -a jid
num_trials=5
script="test.slurm"

for num in $(seq 1 $num_trials); do
   if [ $num -eq 1 ]; then
        jid[$num]=$(sbatch --parsable $script)
    else
        jid[$num]=$(sbatch --parsable --dependency=afterany:${jid[$((num-1))]} $script)
    fi
done