#!/bin/bash
#SBATCH --job-name=run_smk
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=250MB
#SBATCH --time=5:00

source /etc/profile
module load conda
conda activate snakehive

snakemake --profile 12.3_profile