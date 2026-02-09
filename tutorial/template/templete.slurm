#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j_in/%x.out
#SBATCH --err=jobs/%j_in/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2500MB
#SBATCH --time=15:00

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh
conda activate <some_env>

snakemake --profile slurm