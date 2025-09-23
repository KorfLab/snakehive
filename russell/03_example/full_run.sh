rm -r ".snakemake/conda"
python3 "clean.py"
sbatch "03_run.slurm"