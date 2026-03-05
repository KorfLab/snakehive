#!/bin/bash

conda_maker=mk_conda.slurm
workflow_run=run_smk.slurm

step_1=$(sbatch --parsable $conda_maker)
echo $step_1