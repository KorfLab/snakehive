import os

os.system('mamba run -n snakehive snakemake --unlock')
os.system('rm -r .snakemake/conda/*')
os.system('python3 clean.py')
os.system('sbatch 02_run.slurm')