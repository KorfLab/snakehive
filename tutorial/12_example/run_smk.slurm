#!/bin/bash
#SBATCH --job-name=12.3_ex
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

snakemake --profile 12.3_profile