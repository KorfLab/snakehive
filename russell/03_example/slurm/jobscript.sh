#!/bin/bash
#SBATCH --job-name={rule}
#SBATCH --account={resources.slurm_account}
#SBATCH --partition={resources.slurm_partition}
#SBATCH --output=jobs/%j/{rule}.out
#SBATCH --err=jobs/%j/{rule}.err
#SBATCH --cpus-per-task={threads}
#SBATCH --mem={resources.mem_mb}MB
#SBATCH --time={resources.time_min}

source /etc/profile
module load conda
source $(conda info --base)/etc/profile.d/conda.sh
conda activate <some_env>

{exec_job}