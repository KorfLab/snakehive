#!/bin/bash
#SBATCH --job-name=test_envs
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j_wkflow/%x.out
#SBATCH --err=jobs/%j_wkflow/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=300MB
#SBATCH --time=5:00

source /etc/profile
module load conda
conda activate snakehive

snakemake --profile slurm --forceall