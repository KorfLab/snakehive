# 00_example: Intro to Snakemake and the Basics of Rules

## Goal

- Get Snakemake running
- Learn about the minimum requirements to get a snakefile to run

## Installing Snakemake

This Snakemake installation assumes user has the base conda environment
installed and activated.

The easiest way to aquire the Snakemake program is to install it via conda and
the bioconda channel. In the directory outside of the example, `basic.yaml` is
a conda environment that contains snakemake in its most basic form. Create the
environment and activate it with the following commands:

```sh
conda env create -f basic.yaml
conda activate snakemake
```

## Running Snakemake

```sh
cd 00_example
snakemake -c 1
```

Getting snakemake to run is as simple as `snakemake --cores 1`. When running `snakemake --cores 1`, Snakemake looks for `Snakefile` somewhere in the working directory and runs it with one core. The number of cores specifies the maximum number of cores allowed for the run.
> Note: `snakemake -c 1` == `snakemake --cores 1`
- Try `snakemake -c 1`. This will run `Snakefile` and produce a file call `hello.txt` in the results directory containing "hello world".

A specific snakefile can be run using `snakemake -c 1 -s <snakefile>`. `<snakefile>` is a placeholder for the name of the snakefile.
> Note: `snakemake -s <snakefile>` == `snakemake --snakefile <snakefile>`
- Try `snakemake -c 1 -s 0.1_snakefile`. This will create a different file called `greetings.txt` in the results directory containing "greetings from a different snakefile".

## Basics of Snakemake Rules

In order to get a rule to work, there has to be two directives that have to be present. Directives are indicated by an indent followed by the direcitve and a colon. As seen in `Snakefile`, the two required directives are `output` and `shell`. `output` specifies the path of the output file. `shell` runs a shell command.

The `output` directive is where the path of the output file is specified. The path and the name of the output is specified as a string. If multiple outputs are specified, they are in different strings separated by a comma. The different outputs can also be assigned to a variable so they can be specifically referenced later on.

The shell commands that is run on the `shell` can either be a single line string or a multiline string. In `Snakefile`, `rule hello` uses a single line string indicated by the command enclosed by quotes. In `0.4_snakefile`, a multiline string is used indicated by the triple quotes in the first and last line of the shell directive. Single line strings can be useful for running a single short command. Multiline strings are useful for executing multiple commands and organizing long commands.
- Look at `0.2_snakefile`. It uses a multiline string in the shell directive to run `echo` and `cat`.
- Look at `0.3_snakefile`. It uses a multiline string in the shell directive to run a long `echo` command.

Accessing other directives in the shell directory uses the syntax `{<name of directive>}`. When there are multiple outputs, they can be accessed with the syntax `{output[<index>]}`. The index is the same as python, so `{output[0]}` corresponds to the first output. In the case where there is a variable assigned in the directive,the syntax for accessing the variable is `{<directive>.<variable>}`.
- Look at `0.4_snakefile`. It accesses the first output, `results/out1.txt`, by using `{output[0]}` and the second output, `results/out2.txt`, by using `{output[1]}`
- Look at '0.5_snakefile`. It accesses the different outputs with `{output.file_1}` and `{output.file_2}`.

# 01_example:

## Goal

- Learn the basics of important directives
- Able to create and run Snakemake rules with what you have learned so far

## Examples and Explanations

Remember that running a snakefile is `snakemake -c 1 -s <snakefile>`.

### input directive

The input directive is where the path to any inputs for the rule goes. Just like the output directive, the paths to the input files or directories are given in as a string. Multiple inputs are given as strings separated by commas. When an input is assigned to a variable, only the path and the name of the input is in string format. Access to the input is the same as accessing multiple outputs from the output directive.
> The syntax is `{input[<input_index>]}` and `{input.<var_input_name>}`.
- See `1.0_snakefile`. This has a singular input as a string.
- See `1.1_snakefile`. This has multiple inputs as strings separated by commas. Notice how one of the inputs is a directory.
- See `1.2_snakefile`. This has multiple inputs and these inputs are assigned to a variable. Take note on how they are called on in the shell directive.

### output directive

The basics of the output directive have already been covered in `00_example`. One aspect not covered in the previous example is how Snakemake handles directories as outputs. Directories as outputs need to specified with this syntax `directory('<path to dir>')`.
> Note: Snakemake does not check to see if the directory is populated with file, but only checks for the existance of the directory. This is important later when creating more complex workflows.
- See `1.3_snakefile`. This is an example of having a directory as an output.

### shell directive

All the basics have already been covered in the previous example. One great thing about using the shell directive to run code is the ability to run `usr/bin/time` in front of the command to get statistics on the command.
- Remember: Commands must be a string.
- Remember: Accessing other directives in the shell directive uses the syntax `{<directive>[<index>]}`.
- Remember: Accessing directive variables uses `{<directive>.<variable>}`.

### run directive

The run directive runs a python command. There are a couple major differences between the run and shell directives. The first difference is the format of the directive. The shell directive looks for a string to run, whereas the run directive looks for a python command. Another major difference is how other direcitives are accessed within each directive. In the run directive, the directive does not need to be enclosed in curly brackets, {}. Besides those differences, the run directive functions mostly the same as shell.

### script directive

The script directive runs a python script. The script can access the different directives in the rule with the same syntax as the run directive with the addition of `snakemake.` at the front of the directive.
- Look at `1.7_snakefile` and `ex_py_script.py`. The snakefile uses the script directive to access the python script. The python script accesses both the input and output directive from the rule. Notice how it uses `snakemake.input` instead of `input`.

# 02_example: Logs,

## Goal

- Introduce other directives that are useful for Snakemake rules in local runs

## Examples and Explanations

### Target rule

As said in `00_example` the target rule is the rule that comes first. In order to change the target rule

### log directive

The log directive is used to save the standard outputs (stdout) and standard error (stderr) of the rule into a file. Having this directive does not automatically save the stdout of the rule and its commands. This directive can be treated similarly to the input and output directives. They are all called on in the same way, and they can use variables in the directive. Typically, stdout files are stored in a log folder with the `.out` file extention, and stderr files are stored also in the same log folder with the `.err` file extention.
- See `2.0_snakemake`. The log directive contains the log file as a string. The log file is accessed with `{log}` in the shell directive.
> Note: To access the log file in run directive or in a python script, use `log` or `log[0]`.
- See `2.1_snakemake`. This log directive makes use of variables to capture both the standard output and standard error. The log files are accessed with `{log.stdout}` and `{log.stderr}` in the shell directive.
> Note: To access the log files in the run directive or in a python script, use `log.stderr` and `log.stderr`.

### conda directive

The conda dirrective is used to specify and conda environment to run the rule in. The environment is in `.yaml` format and is written as a string in the conda directive. In order to use any conda environment in any rule, `--use-conda` flag __must__ be used in the snakemake command. Conda environments can also be downloaded separately with the `--conda-create-envs-only` flag.
- See `2.2_snakefile`. This is an example of what a rule with the conda directive could like.
> Note: Example of snakemake command. `snakemake -c 1 -s 2.2_snakefile --use-conda`

### params directive

The params directive is useful for specifying options in the shell directive. The main usage is to organize larger commands for easier customization and increased readability.
- See `2.3_snakefile`. The params directive is used to specify which codon is searched for in the grep command. This method of specifying the codon is more clear than if the codon was inserted directly into the command.

# 03_example: Target rule and rule all

## Goal

- Explore what a target rule is
- Learn about `rule all`

## Examples and Explanations

### Target rule

When Snakemake runs, it first looks for a target rule. This is the rule that acts as a goal for the workflow. There are four ways to set a target rule.

The first and easier way to set a target rule is the order of the rules. The rule that comes first on a snakefile will default be set as the target rule.
- Try `snakemake -c 1 -s 3.0_snakefile`. This will only produce `first.txt` even though there is a second rule that produces `second.txt` because `rule first` is a the top of the snakefile.
- Now try `snakemake -c 1 -s 3.1_snakefile`. This will produce `second.txt` because `rule second` is at the top of the snakefile in `3.1_snakefile`.

The second method to set a target rule is through the command line when the snakemake command is ran. The available target rules can be displayed with the `--list-target-rules` flag or `-lt`. The target can be choosen by naming the target rule in the command.
- Try `snakemake -s 3.2_snakefile -lt`. This command will list all the possible target rules.
- Now try `snakemake -c 1 -s 3.2_snakefile grep`. This will produce `grep.txt` in the `results` folder, and this will avoid the other rules in the snakefile.
- Try a different target within `3.2_snakefile`.

The third way to set a target rule is using the `default_target` directive and setting it to `True`. Out of the three methods so far, this is method is the best because it is clear that a rule is the target rule and reduces the length of the command. Calling a target rule in a command will override all methods.
- Try `snakemake -c 1 -s 3.3_snakefile`. This file should only produce `echo.txt` in `results` folder.
- Try `snakemake -c 1 -s 3.3_snakefile grep`. This is produce `results/grep.txt` because rule grep became the target when it was called in the command and overrided the `default_target` directive.

The fourth and final method to setting a target rule is with `rule all`.

### rule all

`rule all` is a special rule because it is the Snakemake default target rule. Normally, input is the only directive used in rule all. The files specified in the input directive of rule all are the targets that Snakemake looks for.
- See `3.4_snakefile`. Notice how rule all only has the input directive and the target file is `results/3.4_grep.txt`. Based on the target, Snakemake is going to look for rule that produces that file and run it.
- Now try `snakemake -c 1 -s 3.4_snakefile`. Notice how the target file is produced from rule grep and rule touch is skipped.
- Try `snakemake -c 1 -s 3.5_snakefile`. Notice how rule grep is skipped and rule touch is ran. This is because the target from rule all is found in rule touch so Snakemake runs this rule.

Another way to think about the interaction between rule all and subsequent rules is that Snakemake tries to match the input of rule all with the outputs of other rules. Based on how they match up, Snakemake will run the rule with the matching output. Congratulations, you have combined two rules to run with one Snakemake run.

# 04_example: Creating a Simple Workflow

## Goals:

- Introduce simple ways to organize workflow
- Create simple workflows by chaining multiple rules to run together

## Organization

In workflows, organization is key to creating massive workflows that stays understandable and user friendly. Creating folders to keep inputs and outputs is one way to do this. As seen before, the results folder holds the majority of the outputs made from rules, and logs holds the logs for the rules when the log directory is used. The new folder introduced in this example is the resources folder.

The resources folder holds the files that is used as inputs for rules to use. Rules can have outputs that produce files in the resources folder that is then used by subsequent rules to produce results. One way to think about which folder files go in is to ask whether the contents of the file achieve the goal of the workflow, or are the contents a tool used by other rules to produce results.

## Examples and Explanations

### Bare Bones

To reiterate what has been said in previous examples, `rule all` is the Snakemake default for a target rule. It noramlly only contains the input directive because the files specified in the input directive are matched up to files from all the other outputs of subsequent rules by Snakemake. Based on which rules contains the matching file in their output directive, Snakemake runs those rules so that the desired files are produced.
- See `4.0_snakefile`. rule all asks for results/part1.txt and Snakemake finds that rule part1 has that file in its output directive. So it runs rule part1 to fulfill rule all.

### Chaining Multiple Rules

Snakemake will automatically create an order for which rules run. This is called a Directed Acyclic Graph (DAG). This is the thing that tells Snakemake what needs to be produced and in which order. It does this by matching inputs with outputs starting from the target rule. Snakemake also has the ability to see which files already exist and skip the rule that creates the file so that there is no redundancy. Take note that Snakemake only looks for the existance of the file and not the contents.
- See `4.1_snakefile`. The output of rule part1 match with the input of rule part2. So rule part1 will run before rule part2. The output of rule part2 matches with rule all. So rule part2 will run to satisfy rule all.
- See `4.2_snakefile`. rule part1 is the same as in `4.1_snakefile`. Assuming `4.1_snakefile` was ran before `4.2_snakefile`, Snakemake will skip the running of rule part1 because the input of rule part3 already exists.

By having the right inputs and outputs, Snakemake is able to run all the necessary rules to complete the target.

# 05_example: Config Files

## Goals:

- Explore config files and what they can do for a workflow
- Look at how config files are organized

## Explanations and Examples

### Config Files

The two most popular methods for accessing a config file in a snakefile is either through the command line or inside the snakefile.

Accessing the config file using the command line requires the `--configfile` flag followed by the path to the config file. To use the different values in the config file, this syntax can be used in any directive `config['<key>']`. Note that the config key that you want to use is in a string format.
- Try `snakemake -c 1 -s 5.0_snakemake --configfile config/5.0_config.yaml`. This should produce `results/config_test.txt` where it accesses the message in `5.0_config.yaml` and writes the message in the text file.
- See `5.0_snakefile` and `config/5.0_config.yaml`. Notice how the key inside of the config file are accessed in the snakefile.

The second way to access a config file is from within the snakefile. At the top of the snakefile `configfile: <path to file>` can be used to access the file. The keys in the config file can be used the same way as before with this syntax `config['<key>']`.
- See `5.1_snakefile`. Biggest thing to note is the syntax to access the config file at the top of the file. Notice how the path is in string format.
- Try `snakemake -c 1 -s 5.1_snakefile`. This should produce a text file containing the message that is in `config/5.1_config.yaml`.

These next examples will showcase how there can be multiple keys in a config file, multiple values in the associate with a key, and a key nested within a key.

- See `5.2_snakefile` and `5.2_config.yaml`. Notice how the config file contains multiple keys. The config keys are able to be accessed by stating the key in the a bracket after calling config.

- See `5.3_config.yaml` and `5.4_config.yaml`. They are the identical. This is done to avoid confusion when being accessed by their respective snakefiles.
- See `5.3_snakefile` and try `snakemake -c 1 -s 5.3_snakefile`. This example rule writes all the different messages in the config file in a list format to a file. This is intended to show how all the values can be accessed at once.
- See `5.4_snakefile` and try `snakemake -c 1 -s 5.4_snakefile`. This example rule writes each individual message in the config file as separate lines to a file. This is indended to show one way to access individual values from a config file.

- See `5.5_snakefile` and `5.5_config.yaml`. This example produces a tab separated table of the amount of people in a fake family. This is intended to show how a config file can have keys that are nested in another key. Also, this shows one method to access these nested keys and their corresponding values.

## Organization

For best practices, config files should go into a separate folder called config. This is done to keep organized and makes it more user friendly by making it easier to find the files that control the workflow. It is generally better to use one config file to control the whole workflow as this also helps with readablity and ease of controlling the workflow.

# 06_example: Wildcards

## Goals:

- Learn about what a wildcard is in Snakemake
- Explore the uses of wildcards for workflows

## Examples and Explanations

### Wildcards

Wildcards are a built in feature of Snakemake that allow workflows to be flexible and reusable. They allow directives to have placeholder variables that can later be assigned with a target rule, a list, or config file. This allows Snakemake to run the same rules but with different inputs or outputs, and allows for the same rules to run in parallel.

Wildcards can be assigned with a target rule by setting a wildcard in the output filename of a different rule while the input of the target rule has a similarly structured input filename. For example the output of a rule is `results/{wildcard}_output.txt`, while the input of the target rule looks like this `results/target_output.txt`. When Snakemake sees this, it will automatically replace `{wildcard}` in the output with `target` from the input. This method of using wildcards is great for making flexible rules.
- See `6.0_snakefile` and `6.1_snakefile`. The only difference between these files is the name of the input file in the target rule. `rule touch` is the exact same in both. However, these two snakefile are able to produce different outputs while running the same exact rule because of the wildcards.

Another way to use wildcards is to have Snakemake run the same rule in parallel with each other. To acheive the effect without wildcards, each separate run would either need its own rule or the user has to manually change the inputs and outputs at the end of each run.
- See `config/goal.yaml`. I want to create a file with the 3 samples (a, b, and c).
- See `6.2_snakefile`. This method of completing the goal is long and repeative because the rules are the same except for the output file name. It is also inconvenient to type out the command to run this because each rule has to be set as a target like this `snakemake -c 1 -s 6.2_snakemake sample_a sample_b sample_c`.
- See `6.3_snakefile`. This snakefile is almost the same as 6.2_snakefile with the exception of rule all. This snakefile utilizes rule all to avoid having to type a long command. The command is now reduced to `snakemake -c 1 -s 6.3_snakefile`. However, the rules in the snakefile are still repetitive.

In order to used wildcards, the `expand()` function has to be used. This function is normally used only in the input directive The syntax is `expand('<filename>{<wildcard>}', <wildcard> = <list of inputs>)`. I understand that might be long and confusing so let us break it down a bit.
- `expand` is just the function name.
- `<filename>{<wildcard>}` is the name of the files that Snakemake will produce. This will contain a wildcard is curly brackets. `sample_{number}` is and example of a possible file where `sample` will be in every file and `{number}` is the wildcard that will be changing every time based on the list it has been assigned.
- `<wildcard> = <list of inputs>` is the part that assigns the wildcard with its values. For example, the list of inputs contains `[a,b]`. Then the wildcard will be 'a' the first run and then it will be 'b' the second run.

These next examples will use the expand function to ensure wildcards work properly.
- See `6.4_snakefile`. rule all is used to so that the expand function can be used in conjunction with wildcards.
- Try `snakemake -c 1 -s 6.4_snakefile`. Notice how the files are produced without a long command and redundent usage to the rules. This method of using wildcards is also good for customization. Changing the config file allows the same snakefile to produce different files.
- See '6.5_snakefile`. This snakefile is the same as 6.4_snakefile except for the use of a list. A python list can be used instead of a config file to achieve the same effect.

Wildcards can also be used in the shell directive. The only difference with using it in the directive versus the other directives is the syntax. In the shell directive the syntax is as follows `{wildcards.<name of wildcard>}`. Whereas other directives it is just `{<name of wildcard>}`.
- See `6.6_snakefile`. This snakefile uses a wildcard in the shell directive. The biggest thing to pay attention to is the different way it is accessed in the shell directive versus other directives.

One of the great things about wildcards is the ability to use multiple wildcards in one rule. Snakemake is able to produce all the possible combinations of wildcards.
- See `6.7_snakefile`. The biggest thing to note here is how each wildcard used in the expand function needs to be assigned to a list of values.
- See `config/6.7_config.yaml`. Notice how there are 2 values for each of the intended wildcards. So at the end, there should be 4 total uniquely labeled files.
- Try `snakemake -c 1 -s 6.7_snakemake`. This example should produce 4 unique files. When looking at the snakemake logs that appear when running snakemake, it should say 5 jobs were completed because of rule all.

The last example just puts everything that was discussed into one snakefile.
- Try `snakemake -c 1 -s 6.8_snakefile`. This is a great example of how snakemake is able to complete 28 jobs effortlessly.

# 07_example: Modules

## Goal:

- Explore how modules help with workflow organization and flexability

## Explanations and Examples

### What is a Module

Module is a method of accessing other snakefiles from another snakefile. This allows either the whole snakefile or specific rules to be used in other parts of the snakefile. This is useful for creating a toolbox of rules for your workflow. For example, a rule that checks the resource usage of another rule would be something that can be implemented multiple times in a workflow. Another usage for using modules is being able to use rules between different projects.

### Organization

Usually, snakefiles that are not the main snakefile are put into a folder called `rules`. They also have the `.smk` extention. This is so that the rules are organized in a large workflow where there can be many different snakefiles each with many rules. Having lots of files in the working directory can make it hard for newer users to use the workflow, and the clutter makes it harder to find specific files.
- See `rules` folder. The snakefiles in there all have the `.smk` extention.

### How to Use Modules

Modules have a similar structure to rules, but the differences come in the directives and an extra line at the end. The first line of a module is `module <name of the module>`. The name of the module can be anything and does not have to be associated with the snakefile it will reference. Following the naming of the module, the `snakefile` directive is typically used to specify the path of the snakefile that the module will pull from. After all the modules are specified, the rules from each module has to be stated. The syntax for this is `use rule <rule name in snakefile> from <name of module>`. Modules allow for rules to be selected from a snakefile allowing for finer control over what goes into a workflow.
- See `7.0_snakefile`. Just like with any workflow, rule all is used as the target rule. Then `rules/touch.smk` is imported in as a module. Then it specifies that it wants to use rule touch from within the `make_file` module.

These examples will showcase some of the use cases of modules. All of these examples will pull from the same snakefiles in the rules folder.
- See `7.1_snakefile` and try `snakemake -c 1 -s 7.1_snakefile`. This snakefile is an example of how to use two rules from two different modules.
- See `7.2_snakefile` and try `snakemake -c 1 -s 7.2_snakefile`. This snakefile showcases how a single rule from a module containing multiple rules can be used.
- See `7.3_snakefile` and try `snakemake -c 1 -s 7.3_snakefile`. This example showcases one method for accessing multiple rules inside of module containing multiple rules. This is same as `7.1_snakefile` where it uses multiple rules.
- See `7.4_snakefile` and try `snakemake -c 1 -s 7.4_snakefile`. This example shows a method for accessing all the rules in a module. This is useful for when the whole module is used and it contains multiple rules.

Another important directive for modules is the config directive. This gives the module snakefile access to a config file. It is the same as specifying `configfile: <name of config>` at the top of of the snakefile. However, using the config directive for a module allows the module snakefile to have the flexiblity to have different configs without requiring the use to go into each snakefile and manually input the config.

In order to use a config file in modules, a config file has to be set in the main snakefile through any of the methods discussed in the config file section `05_example`. Then `config` can be put into the `config:` directive. This works because the contents of a config file is set to `config` variable by default.
- See `7.6_snakefile` and `7.7_snakefile`. The big thing to note in these functionally same snakefiles is how config is used in the module.
- Now try `snakemake -c 1 -s 7.6_snakefile` and `snakemake -c 1 -s 7.6_snakefile`. The differences in the contents of the two output files is due to the differences of the config file. This is a great example of how a workflow can be reused by simply changing the config file.

# 08_example: Profiles

## Goal:

- Learn about profiles and how they help with running a worflow
- Introduce organization for profiles

## Explanations and Examples

### Profiles

Profiles allows Snakemake to be run with a shorter command. It allows all the options to be put into a yaml file. It also makes it easy to run the workflow with different options without having to type out the whole command each time.

To use a profile, there has to be a format the Snakemake recognizes. There has to be a directory with specifically `config.yaml` in that directory. The name of the directory does not matter for function, but it should be descriptive of how the workflow is run. `config.yaml` that lives inside of the profile direcory has to be exactly `config.yaml` because Snakemake will look for this file when running a profile to determine the options and flags used in the run.
- See `run_8.0/config.yaml`. Notice how the name of the profile is descriptive. The file inside of the directory is exactly `config.yaml`. The options that would be noramlly used is in the config file.
- Try `snakemake --profile run_8.0`. This is the same as running `snakemake -c 1 -s 8.0_snakefile`.

Target rules can also be specified in the profile config file. Normally on the command line, the target rule is just stated at the end of command by itself with no flag. This cannot be replicated in the config file, so the workaround is to use the `--until` flag. This flag will complete the workflow until the specified target rule.
- See `run_8.1/config.yaml`. This profile config file uses the until flag to target rule touch. The target can be changed to any rule in the snakefile.
> Reminder that `snakemake -s 8.1_snakefile -lt` can be used to check possible target rules.
- Try `snakemake --profile run_8.1`. This will produce the output of the target rule set in the profile config.
> Same as running `snakemake -c 1 -s 8.1_snakefile touch`.

Profiles are also able to include conda environment usage. There can be one profile to just create conda environments, and there can be another profile to run the snakefile. This is useful later on in resource management.
- See `conda_8.2`. This profile is set up to only create conda environments for `8.2_snakefile`. It is best practice to create the conda environments separately from running the snakefile.
- See `run_8.2`. This profile is set up to run `8.2_snakefile` with conda environments.
> These two profiles can be called upon in a script so that they are run on after another.

## Organization

Profiles are put into a folder depending on its purpose. If the profile is set up for local execution, then an appropriate name could be `local`. If a profile is set up for slurm execution, then `slurm` could be an appropriate name.

# 09_example: Putting Together a Workflow

## Goals:

- Learn how to organize a whole workflow
- Showcase what a proper organized workflow could look like

## Organization

One thing to keep in mind with organization is that its purpose is to make it the workflow easier to use for users and easier to edit if needed. The best organization is one that is simplest. However, the organizational structure is best practices for Snakemake and is intended to accomodate larger and more complicated workflows with more parts.

The first level of this organization structure contains config, resources, results, workflow, and the other two being profiles. The choice to leave profiles at the first level is supposed to make it easier to run the workflow on the command line. The workflow contains everything that runs in the workflow. The contents of the workflow directory is not intended to be editted if the users not developing the workflow. Users are intended to interact with the config, resources, and results directory.
- `config`: This is where users change how the workflow behaves. For this example, the config is where the codons that are meant to be searched are listed and the path to the genome.
- `resources`: This is where the user would populate the input files. For this example, this is where the genome is stored.
- `results`: This is where the end results of the workflow go. For this example, a file with the input and output of rule script and all the codon counts get populated in this directory once the workflow finishes.

There are two profiles for this example. `only_conda` is meant to only download conda environments. `run_ex` runs this example. The separation of the two is important later when working with the cluster.

The only directory in this organizational structure that has more levels is the workflow. This directory is where all the computation happens.
- `Snakefile`: This the main snakefile that controls the workflow. It is important to that the main snakefile is name `Snakefile` because that is the default snakefile that Snakemake looks for when not given a specific snakefile.
- `envs`: This contains all the instructions for the conda environments used in the workflow. For this example, the only conda environment contains the usr/bin/time version of time.
- `logs`: This directory contains all the logs that is produced by the snakefiles. Logs are not in the first level because it is not usually interesting for users when there is no issues. In this example, the log contains the resources rule codon uses.
- `rules`: This contains all the other snakefiles that is not the main one. In this example, two other snakefiles are used by modules in the main snakefile.
- `scripts`: This is where all the scripts used in rules reside. In this example, only one rule uses a script so only one script is in the directory.

With everything discussed up until this point. You should be able to start creating Snakemake workflows and running them locally. The later examples will go over how to properly use Snakemake with HIVE.

# 10_example: Basics for Running Snakemake on Hive

## Goal

- Get familiar with the a SLURM script
- Run basic Snakemake on Hive

## Getting access to Hive

- Getting account

## Using Hive as a local computer

Note: All commands will be run on the Hive terminal and not your local computer's terminal for this section.

The most basic way to use Hive is to run scripts interactively on a terminal like you would on a terminal from a local machine. To open a terminal on Hive, first request an interactive session with Hive OnDemand with `publicgrp` account, `low` partition, `1` core, `4` GB of RAM, and `1` to `2` hours. The number of GPUs is `0` and the GPU type can be left blank. This should open a session rather quickly. 

Launch the Hive desktop when the session begins. Open the terminal using the second icon at the bottom on the screen. This icon should be a black box with a dollar sign and an underscore in the box. To activate Conda on Hive, use the command

```sh
module load conda
```

Clone this github repo in the directory of your choosing make `10_example` the working directory in the Hive terminal. The purpose of the following example is to show how the Hive terminal can be used like the terminal on your local computer.

- Try the command below. `10.0_hello.py` is a simple script that prints `hello world`.

    ```sh
    python3 10.0_hello.py
    ```

## Running a script in Hive through Slurm

The main method of running scripts on Hive is by submitting a job through a slurm script with the sbatch command. Your active jobs can be seen with by using the following command in the Hive terminal.

```sh
squeue -u <username>
```

> Note: `<username>` is a placeholder for your user name on Hive.
- `-u` flag is for seeing jobs from a particular user, other flags can be seen with the following command used in the terminal.

    ```sh
    squeue --help
    ```

- Tip: The following command will allow `squeue -u <username>` to run every second essentially allowing you to keep track of your jobs in real time without having to rerun `squeue`. Use `ctrl + c` to cancel the command.

    ```sh
    watch -n 1 "squeue -u <username>"
    ```

Another useful slurm command is `scancel`. This followed by a jobid allows a specific job to be terminated. The different `scancel` options can be viewed with the help page, with the command shown below.

```sh
scancel --help
```

Run the following command that will run a slurm script which will result in `hello world` printed to _____.

```sh
sbatch 10.1_ex.slurm
```

> Note: When running a job with slurm, it will automatically get assigned an unique jobid.

Review of `10.1_ex.slurm` line by line.
- `#!/bin/bash` specifies that this script uses a bash shell
- `#SBATCH --job-name=10.1_ex` specifies the name of the job attached to. In this example, the job name is `10.1_ex`. This job name is not exclusive for this job. So multiple jobs can have the same job name but they will always have different jobids. `#SBATCH` is called an slurm directive.
    > Note: `%x` can be used as a variable placeholder for the jobname is other #SBATCH directives. Examples will be given later.
- `#SBATCH --account=publicgrp` specifies which account to queue the job into. In this example, the account is `publicgrp`. If the lab or organization has its own account that you would like to queue the job into, this line can be changed to get bigger jobs out of the queue faster.
- `#SBATCH --partition=low` specifies the partition used. For these examples, low partition is always used.
- `#SBATCH --output=jobs/%j/%x.out` specifies the name of the output file and the path. In this example, the output will be put into a folder called jobs and in another folder with the jobid as its name. The file itself will be the jobname.
    > Note: `%j` is a placeholder for the jobid. `%x` is a placeholder for job name.
- `#SBATCH --err=jobs/%j/%x.err` specifies the path and the name of the error file. In this example, the error folder will also go into the jobs folder and the folder with the jobid name, but it will have `.err` file extension instead of `.out`.

- `#SBATCH --cpus-per-task=1` specifies the number of cpus the job will use. In this example, the number of cpus requested is 1. The number of cpus should be kept to a minimum to allow resources for other users and it gets your job out of queue faster.

- `#SBATCH --mem=40MB` specifies the amount of memory this job gets. This example requests 40MB of memory. The amount of memory requested is important because using the minimum amount of memory for a job does not tie up resources for other users and allows your job to get out of queue faster.

- `#SBATCH --time=1:00` specifies the time limit for the job. This example requests 1 minute. The time chosen should be enough to allow the job to run completely but not too much as to hold up resources when a job is stuck in a continuous loop.

- `source /etc/profile` initializes the module system when first running the job. This is important so that the conda module can be loaded in.

- `module load conda` loads the conda module and activates the base environment.

- `python3 hello_saved.py` is the command that we want to run. In this example, a text file is produced with 'hello world' printed inside.

## Snakemake on Hive

explain snakemake on hive and how interactive and sbatch is different how it submits jobs the min requirements explain slurm and adding it to environments

# 11_example: Resource Management for Workflows on HIVE

# 12_example: Conda in Snakemake on Hive

# 13_example: Slurm Profiles

# 14_example: More Example Workflows





work in progress
--------------------------------------------------------------
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

- `rules` is where all the Snakemake rules are stored. They end with the `.smk` extension to indicate that it is a Snakemake rule. They are kept separate from the main snakefile so that it keeps the snakefile concise and easy to read.

- `scripts` is where all the scripts that are run by the snakefile rules are stored. They are kept together for organization. They can be either R or Python scripts.

`templete.slurm` is an example script that would be submitted to hive. This templete script starts the default lines for using conda in a script. Submitting a job to the cluster will create a directory called `jobs` where all cluster outputs will go.

`slurm` contains the profile for running Snakemake on the cluster and the script that Snakemake will submit to the cluster for each rule.
> As a reminder Snakemake looks for `config.yaml` specifically when using a profile.

- In `slurm/config.yaml` the `executor` key specifies which job scheduler to use. `slurm` is not one of the default schedulers that comes with Snakemake, so it has to be separately installed via Conda.

- Increasing the number of `jobs` allows Snakemake to schedule more jobs at the same time.

- `use-conda` is required when planning to use conda environments in the workflow.

- `latency-wait` is important for making sure output files are visible on other nodes once the node working on the file writes into it. Without sufficent `latency-wait` time, Snakemake can incorrectly fail a job.

- `default-resources` allows for the jobs that Snakemake submit to be customized.

- `slurm-keep-successful-logs` and `slurm-logdir` allow for the logs from each Snakemake job submission to be kept, and gives it a place to be sent to. Without `slurm-logdir`, the logs will be sent to `.Snakemake/slurm_logs`.

# 00_example

## Goal

- Show example of what a basic Snakemake pipeline looks like
- Use best practices when writing a pipeline
- Run Snakemake locally

## Explanation of Snakefile

`configfile` is specifies the global config file for this Snakefile. It can be called on by using the variable `config` (no quotes), or it can be called on in scripts using `Snakemake.config`. Specific configs can be called on with this syntax `config['<some_variable>']`.

`rule all` should be the first rule in any Snakefile. It is the default rule that Snakemake looks for as its target rule.
- Target rule is the rule that specifies the intended output for the whole Snakefile.

`module` loads in a snakefile of rule/s that is from somewhere outside of this Snakefile. For best practices all snakefiles loaded in with module must have the `.smk` extension. This will make it clear what kind of file it is just by the name. Modules need to contain a `config` directive if the rule that the module runs uses a script. When running shell commands, there does not need to be a `config` directive. `config` directive should also be used when referencing a config inside of a rule.

`use rule * from <module>` tells Snakemake to use all rules from a specific module. The rule that is used can be customized and does not have to be `*`.

### Explanation of Snakemake Rules

All rules with the exception of `rule all` should contain these directives:
- output
- log
- conda

`output` is needed so that the rule produces something.

`log` is used to specify the names and/or paths of log files. This directive should contain `stdout` and `stderr` and have the file extentions `.out` and `.err` respectively. Separating standard output and standard error allows each to be differentiated easier without having to tag each output in a single file.

`conda` is used to specify a yaml file containing instructions for a conda environment. Depending on the purpose of the Snakefile, this should either be set per file or per rule. Setting a conda environment helps with reproducibility.

`shell` is used to run shell commands.

### Explanation of Snakemake Scripts

Snakemake can take either python or R scripts. For python scripts, variables in the rule that script is run in can be accessed with `Snakemake.<directive>[0]`. This is refering to the first variable or string in a directive.

Scripts can also be run in the shell directive. They would run like they would normally on the command line. In `mk_input.smk` rule, `mk_input.py` is called on and arguments are passed with sys.argv.

Either method of using a script in Snakemake is fine. However, running a script by passing arguments in the with the shell directive is more favorable because it allows to script to be used independently from the workflow.

# 01_example

## Goal

- Show how Snakemake interacts with slurm
- Adhere to best practices by finding the minimum required resources for a job

## Explanation of Slurm Directory

The cleanest way to run Snakemake is to use profiles since they allow for the desired Snakemake options to be neatly put into a yaml file. When running Snakemake as a job in hive, specifying `jobs` instead of `cores` is needed because using `cores` will run Snakemake locally instead of on the cluster.

In order to run each rule separately, Snakemake automatically creates and submits its own jobscripts to the cluster. This will allow Snakemake to submit a unique job to the cluster for each rule. This process is important because it allows each rule to run with its own resources. So one rule can use more resources when a different rule can use less.

## sbatch script

There are two sbatch scripts that run Snakemake `01_run.slurm` and `test/test.slurm`. The only difference between the two is that `test.slurm` is used to test the entire workflow from start to finish.
- `test.slurm` will recreate all conda environments and rerun all the rules.
- `01_run.slurm` is what you would see in a functioning workflow. It will only create conda environments if needed and only run rules as needed.

## Memory usage finder

It is good practice to only request resources as needed. Requesting too much waste resources that someone else can use, and requesting too little kills the job. It is always recommended to find the maximum amount of resources the job and each rule takes.

`test/run_checker.sh` and `test/get_mem.slurm` are used to submit multiple of the same jobs and collect the maximum about of memory used by Snakemake.

The memory and time used by each job can be obtained by running `sacct --format=jobid,state,maxrss,reqmem,elaspsed,timelimit -j <jobid>`.

# 02_example

## Goal

- Provide exmaple of wildcard usuage
- Provide example of how config files are used
- Provide example of `params` directive
- Show how python code can be used in Snakefiles
- Provide example of multithreading

## Snakefile Explanation

`rule all` is where wildcards are expanded using `expand()`.  `expand()` used in conjunction with wildcards allows multiple similar files to be called on without having to explictly stating each one. In this case, the name of the wildcard is `num` and it corresponds `trials` in the config file.

## More Snakemake Rules Explanation

In any rule, contents of a config file can be accessed using `config['<someconfig>']`. When a .smk file is used in the main Snakefile, the config file must be specified in a directive called `config` in the module. After specifying the config file in the main Snakefile, configs can be accessed in the .smk file as if it is part of the main Snakefile.

`params` is a directive that allows for more variables to be specified outside of the code that is run. In this example, `rule get_read` uses params as a way to control the length and amount of reads generated, and these variables are meant to be changed depending on the user's wants. For best practices, variables that are meant to be changed should call upon a config from the config file because the goal is to have only one file that controls the operation of the Snakemake pipeline. `params` can also be used as a way to organize options for flags as seen in `rule mk_db`. Since some flags are static, `params` is not necessary.

`threads` is a directive that specifies the number of threads a rule can use. If the number of cores is less than the specified threads, Snakemake will automatically use less threads instead of erroring out. For best practices, the number or threads should be optimized for memory usage and time.

One important note is that using a directory as an output in a rule requires `directory(<dir>)` to be specified.

## Why Use Config Files

Config files are used as a way to control the Snakemake pipeline. It provides the user with one file where all the options for the pipeline are stored, and modifying the pipeline only takes modifying one file. Having one file that controls the pipeline allows it to be flexable and organized.

## Python code in a Snakefile

Any amount of python code can be used before `rule all` is specified. This can be useful for generating a list that gets used as a wildcard in the following rules. It is possible to specify configs like python variables, but this goes against best practices because it could make the Snakefile messy and harder to follow.

## Resource management

In this example, finding the amount of resources is different than `01_example`. This uses `full_run.py` to rerun the entire pipeline with conda installation and clearing the existing files. This command `sacct --format=jobid,state,maxrss,reqmem,elaspsed,timelimit -j <jobid>` is still used after the run to see specifically the amount of resources used.

The program `summary.py` takes in a range of jobids and runs `sacct --format=jobid,state,maxrss,reqmem,elaspsed,timelimit -j <jobid>` on all of them and prints them out. It allows all the resources of the different jobs to be printed to standard out.

# 03_example

## Goal

- Create an example of Snakemake submitting many multiple jobs in parallel
- Show example of using

## Explanation

The formatting of the workflow is similar to `02_example`. The only difference being the use of dust, a low complexity filter for Blast. Changing the settings for this filter allows for the same inputs to generate different output.

Snakemake is great with taking similar jobs and running them parallel. This allows for massive workflows to be done quicker especially on clusters. It is much easier to get a job to run on a cluster if they request less resources. So breaking up a large workflow to work in parallel allows it get out of the cluster queue faster.

## Snakefile and Rules

The main difference between the `02_example` and this example is the use of `rule compare` and the input for `rule all`. The input for `rule all` is only one file so that means the wildcards have to expanded in a different rule. In this example, `rule move` was used to expand the wildcards allowing Snakemake to call for the desired outputs.

The potentially interesting aspect of the workflow is the use of `rule move`. The purpose of the rule is to make sure that the directory `results/blast` is made and that all the finished files are put into that directory so that `rule compare` is able to use `results/blast` as an input. This is a design choice of the workflow because the script used to combine all the blast outputs uses a directory instead of inputing each individual file. When planning on using a directory as an input for a rule, Snakemake does not check whether or not the directory has files, but Snakemake only cares for existence the directory. This can lead to failed workflows without the presence of the completed input files. Ultimately, this can be avoided if the inputs were files, but this makes can make a directory cluttered and unorganized.
