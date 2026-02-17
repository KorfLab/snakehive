#!/bin/bash
#SBATCH --job-name=11.3_ex
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=200MB
#SBATCH --time=5:00

source /etc/profile
module load conda
conda activate snakehive

snakemake -j 1 -s search.smk --latency-wait=60 --executor slurm \
--default-resources slurm_account=publicgrp runtime=5 slurm_partition=low \
mem_mb=750 --forceall