#!/bin/bash
#SBATCH --job-name=10.1_ex
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=128MB
#SBATCH --time=1:00

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh
conda activate snakehive

command time -v python3 hello_saved.py