#!/bin/bash
#SBATCH --job-name=10.1_ex
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=5MB
#SBATCH --time=0:30

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh

python3 10.0_hello.py