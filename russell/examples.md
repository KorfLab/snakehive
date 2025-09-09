# Template

## Goal
- Act as a simple starting point for a Snakemake pipeline
- Adhere to best practices for Snakemake

## Explanation
`resources` is where all files that are used in the pipeline goes. Some example of these are genomes or sequencing reads. The reason they are not incorporated with the workflow is that they can be used in other workflows. So having them outside of a workflow allows them to be easily accessed by other workflows.

`results` is where the results of the workflow go. This folder is outside of the workflow just to make it easier to access results and it is not directly used in the workflow.

`local` is used in the CLI Snakemake command as a profile to tell Snakemake what specifications to run with. For example, number of cores or amount of memory are different things that can be put into a config file. Snakemake looks specifically for `config.yaml` when using the `--profile`.

`config` holds `config.yaml` where different parameters are put that are used in multiple rules. For example, names of sample or path to reference genome. The name yaml file inside of `config` can be changed

`workflow` is where the all the files that get Snakemake pipeline to work go.

- `Snakefile` is the file that Snakemake references to run the pipeline. Snakemake specifically looks for the snakefile to be named `Snakefile` as a default. To specify a different name, use `--snakefile` or `-s` flag followed by the snakefile name.

- `envs` is where all the different environments used in the pipeline are stored. They have their own folder for organization. All environments have the `.yml` or `.yaml` extension.

- `logs` is where the logs for the pipeline goes. It usually contains stdout and stderr files for the rules that are ran.

- `rules` is where all the snakemake rules are stored. They end with the `.smk` extension to indicate that it is a snakemake rule. They are kept separate from the main snakefile so that it keeps the snakefile concise and easy to read.

- `scripts` is where all the scripts that are run by the snakefile rules are stored. They are kept together for organization. They are either R or Python scripts.

`templete.slurm` is an example script that would be submitted to hive. This templete script starts the default lines for using conda in a script. Submitting a job to the cluster will create a directory called `jobs` where all cluster output will go.

`slurm` contains the profile for running snakemake on the cluster and the script that Snakemake will submit to the cluster for each rule.
> As a reminder Snakemake looks for `config.yaml` specifically when using a profile.
- `slurm/config.yaml` has two notable keys. `executor` specifies which job scheduler to use. `slurm` is not one of the default schedulers that comes with Snakemake, so it has to be separately installed via Conda. The other notable key is `jobscript`. This has to be added so that Snakemake knows where to find the script to submit to slurm.
- `slurm/jobscript.sh` has two notable aspects. The first one being how all the sbatch dependencies are variables. This is so that each rule that is submitted to the cluster can run with uniquely specified resources. Another notable aspect is `{exec_job}`. This is a placeholder that Snakemake replaces later on with the command to run.

# 00_example

## Goal
- Show example of what a basic Snakemake pipeline looks like
- Use best practices when writing a pipeline

## Explanation of Snakefile
`configfile` is specifies the global config file for this Snakefile. It can be called on by using the variable `config` (no quotes), or it can be called on in scripts using `snakemake.config`. Specific configs can be called on with this syntax `config['<some_variable>']`.

`rule all` should be the first rule in any Snakefile. It is the default rule that Snakemake looks for as its target rule.
- Target rule is the rule that specifies the intended output for the whole Snakefile.

`module` loads in a snakefile of rule/s that is from somewhere outside of this Snakefile. For best practices all snakefiles used loaded in with module must have the `.smk` extension. This will make it clear what kind of file it is just by the name. Modules need to contain a `config` directive if the rule that the module runs uses a script. When running shell commands, there does not need to be a `config` directive.

`use rule * from <module>` tells Snakemake to use all rules from a specific module. The rule that is used can be customized and does not have to be `*`.

### Explanation of Snakemake Rules
All rules with the exception of `rule all` should contain these directives:
- output
- log
- conda

`output` is needed so that the rule produces something.

`log` is used to specify the names and/or paths of log files. This directive should contain `stdout` and `stderr` and have the file extentions `.out` and `.err` respectively. Separating standard output and standard error allows each to be differentiated easier without having to tag each output in a single file.

`conda` is used to specify a yaml file containing instructions for a conda environment. Depending on the purpose of the Snakefile, this should either be set per file or per rule. Setting a conda environment helps with reproducibility.

`shell` is used to run shell commands as Snakemake cannot run shell scripts.

`script` should almost always used to run python code instead of using `run` directive. The reason for this is that it keeps the Snakefile cleaner and allows the code to be reused in other Snakefiles. Using a script also allows for easier testing without having to run the Snakefile.

### Explanation of Snakemake Scripts
> Note: The script directive is not used in this example in order to use usr/bin/time -v on the running of the script.

Snakemake can take either python or R scripts. For python scripts, variables in the rule that script is run in can be accessed with `snakemake.<directive>[0]`. This is refering to the first variable or string in a directive.

Scripts can also be run in the shell directive. They would run like they would normally on the command line. In `mk_input.smk` rule, `mk_input.py` is called on and arguments are passed with sys.argv.

# 01_example

## Goal
- Show how Snakemake interacts with slurm
- Adhere to best practices by finding the minimum required resources for a job

## Explanation of Slurm Directory
The cleanest way to run Snakemake is to use profiles since they allow for the desired Snakemake options to be neatly put into a yaml file. When running Snakemake as a job in hive, specifying `jobs` instead of `cores` is needed because using `cores` will run Snakemake locally instead of on the cluster.

In order to run each rule separately, a jobsript has to be specified in the slurm profile. This will allow Snakemake to submit a unique job to the cluster for each rule. This process is important because it allows each rule to run with its own resources. So one rule can use more resources when a different rule can use less.

## sbatch script
There are two sbatch scripts that run snakemake `snakerun.slurm` and `test.slurm`. The only difference between the two is that `test.slurm` is used to test the entire workflow from start to finish. 
- `test.slurm` will recreate all conda environments and rerun all the rules. - `snakerun.slurm` is what you would see in a functioning workflow. It will only create conda environments if needed and only run rules as needed.

## Memory usage finder
It is good practice to only request resources as needed. Requesting too much waste resources that someone else can use, and requesting too little kills the job. It is always recommended to find the maximum amount of resources the job and each rule takes.

`run_checker.sh` and `get_mem.slurm` are used to submit multiple of the same jobs and collect the maximum about of memory used by snakemake. 

The memory used by each job can be obtained by wrapping the command in `usr/bin/time`. In this example, the time command was installed in the conda environment and called upon in the rule.

# 02_example

## Goals:
- Provide exmaple of wildcard usuage
- Provide example of how config files are used
- Provide example of `params` directive
- Show how python code can be used in Snakefiles
- Provide example of multithreading

## Snakefile Explanation
`rule all` is where wildcards are expanded using `expand()`.  `expand()` used in conjunction with wildcards allows multiple similar files to be called on without having to explictly stating each one. In this case, the name of the wildcard is `num` and it corresponds `trials` in the config file.

## More Snakemake Rules Explanation
In any rule, contents of a config file can be accessed using `config['<someconfig>']`. When a .smk file is used in the main Snakefile, the config file must be specified in a directive called `config` in the module. After specifying the config file in the main Snakefile, configs can be accessed in the .smk file as if it is part of the main Snakefile.

`params` is a directive that allows for more variables to be specified outside of the code that is run. In this example, `rule get_read` uses params as a way to control the length and amount of reads generated, and these variables are meant to be changed depending on the user's wants. For best practices, variables that are meant to be changed should call upon a config from the config file because the goal is to have only one file that controls the operation of the Snakemake pipeline. `params` can also be used as a way to organize options for flags as seen in `rule mk_db`.

`threads` is a directive that specifies the number of threads a rule can use. If the number of cores is less than the specified threads, Snakemake will automatically use less threads instead of erroring out. For best practices, the number or threads should be optimized for memory usage and time.

## Why Use Config Files
Config files are used as a way to control the Snakemake pipeline. It provides the user with one file where all the options for the pipeline are stored, and modifying the pipeline only takes modifying one file. Having one file that controls the pipeline allows it to be flexable and organized.

## Python code in a Snakefile
Any amount of python code can be used before `rule all` is specified. This can be useful for generating a list that gets used as a wildcard in the following rules. It is possible to specify configs like python variables, but this goes against best practices because it could make the Snakefile messy and harder to follow.