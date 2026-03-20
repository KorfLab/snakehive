#!/bin/bash
#SBATCH --job-name=mk_conda_envs
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000MB
#SBATCH --time=15:00

source /etc/profile
module load conda
conda activate snakehive

snakemake --profile mk_envs