# Ideas of what kind of pipelines to make

## Step 1

Parameters:
- no installation
- relevant
- best practices

## Types of directive
- input: name/s of the file/s used in the rule as input.

- output: name/s of the file/s the rule will output.

- shell: shell commands to run.

- run: block of python code to run.

- script: gives a script for a rule to run.
    - Python scripts can access snakefile directives with `snakemake.<directive>`
    - can also use explicit import: `from snakemake.script import snakemake`

- conda: name of yaml file that has the conda environment that the rule would use.
    - Snakemake prioitizes channels at the top of yml files.
    - Using default channel not recommended for reproducibility.
    - Able to pin conda env using `snakedeploy pin-conda-envs envs/ggplot.yaml`.
    - Able to update env to have all the latest package versions `snakedeploy update-conda-envs envs/ggplot.yaml`.
    - `snakemake --containerize > Dockerfile` can be used to create a container for a conda env.

- log: specifies a file where info about the execution is written

- threads: specifies the number of threads for the job. Snakemake will automatically use less threads if less cores are specified in cli. This can also be a function or variable.

- resource: can specify `mem`, 'disk`, and `runtime`.
    - both `mem` and `disk` have the syntax `mem_mb=16` -> 16 megabytes
    - `runtime`, if given as a int, is in minutes. If given in a string format, time units can be specified.

- message: can print a message when running a rule.

- priority: allows for rules to have a priority of execution. `-n` or `--dry-run` will show execution order.

- params: allows for other parameters that are outside of the script or run block. For example, fdr can be a variable in params and be called on in the script or run block with `params.fdr`.

- wildcard_constraints: can restrict the wildcard to only using a specific regular expression.
    - `<wildcard>='\d+'` restricts the wildcard to digits only.

- default_target: set `True` or `False`. Sets the rule to be the default_target. This is usually `rule all`.

## Best practices
- Keep workflow in its own folder with envs, scripts, and the snakefile
    - `./workflow/envs` `./workflow/scripts` `./workflow/snakefile`

- Put results in its own folder outside of workflow
    - `workflow/` `results/`

- Put config files in its own folder outside of other folders
    - `workflow/` `results/` `configs/`

## Ideas
- test amount of resources
- use dusk in blast
- lots of reads to run in parallel for blast


## things to do when i get back
- keep trying to get snakemake to run not locally and fail when given too little memory

- test memory usage for each action and create a graph

- sbatch rule without memory specified but using `cluster` in profile

## stashed code
cluster: "sbatch --mem={resources.mem_kb}K --cpus-per-task={threads} --time{resources.runtime}"
default-resources:
  - mem_kb=10000
  - threads=1
  - runtime=15

sacct -j 4069835 --format=JobID,JobName,MaxRSS,MaxVMSize,State
jid=$(sbatch --parsable mem_test.slurm)
sbatch --dependency=afterany:$jid log_mem.slurm
sacct -j 4551766 --format=JobID,State,MaxRSS,ReqMem

shared_storage_local_copies: True
remote_exec: False


jobs: 1
use-conda: true
conda-frontend: mamba
latency-wait: 10

results/blast_out{num}.txt

8-20: works rm but cant oom a single rule yet must investigate further
8-21: success now have to document
8-24: THings to do
8-29: reduce the size of `blastn -task megablast` to 11 or so. generate millions of reads. use bigger genome. try threads and see if it affects speed. if does translate to slurm n run on cluster for further testing.