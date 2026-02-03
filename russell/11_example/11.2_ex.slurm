#!/bin/bash
#SBATCH --job-name=11.2_ex
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

snakemake \
--jobs 1 \
--executor slurm \
--snakefile hello_snakefile \
--default-resources \
slurm_account=publicgrp \
runtime=3 \
slurm_partition=low \
mem=100M \
--latency-wait 60 \
--forceall