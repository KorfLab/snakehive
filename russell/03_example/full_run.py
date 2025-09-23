import os

os.system('rm -r .snakemake/conda')
os.system('python3 clean.py')
os.system('sbatch 03_run.slurm')