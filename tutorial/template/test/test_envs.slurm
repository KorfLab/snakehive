#!/bin/bash
#SBATCH --job-name=test_envs
#SBATCH --account=publicgrp
#SBATCH --partition=low
#SBATCH --output=jobs/%j_envs/%x.out
#SBATCH --err=jobs/%j_envs/%x.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000MB
#SBATCH --time=10:00

source /etc/profile
module load conda
conda activate snakehive

rm -rf .snakemake/*
snakemake --profile mk_envs