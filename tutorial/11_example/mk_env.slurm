#!/bin/bash
#SBATCH --job-name=mk_env
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2500MB
#SBATCH --time=10:00

source /etc/profile
module load conda
conda activate snakehive

snakemake -j 1 --use-conda -s test.smk --conda-create-envs-only