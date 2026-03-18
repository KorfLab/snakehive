#!/bin/bash
#SBATCH --job-name=01_run
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=250MB
#SBATCH --time=10:00

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh
conda activate snakehive

snakemake --profile slurm