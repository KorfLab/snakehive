#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j/%x.out
#SBATCH --err=jobs/%j/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=250MB
#SBATCH --time=10:00

bash test/check_envs.sh