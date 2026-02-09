#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j_check/%x.out
#SBATCH --err=jobs/%j_check/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2500MB
#SBATCH --time=20:00

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh
conda activate snakehive

mkdir -p prev_tests/$SLURM_JOB_ID
[ -f results/blast_res_usage.pdf ] && mv results/blast_res_usage.pdf prev_tests/$SLURM_JOB_ID/blast_res_usage.pdf
rm -r .snakemake/conda/*
snakemake --profile slurm --forceall