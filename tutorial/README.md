# 00_example: Intro to Snakemake and the Basics of Rules

## Goals

- Get Snakemake running
- Learn about the minimum requirements to get a snakefile to run

## Installing Snakemake

This Snakemake installation assumes user has the base conda environment
installed and activated. If not, go to
`https://github.com/conda-forge/miniforge` and follow its instuctions to do so.

The easiest way to aquire the Snakemake program is to install it via conda and
the bioconda channel. In the directory outside of the examples, `basic.yaml` is
a conda environment that contains snakemake in its most basic form. Create the
environment and activate it with the following commands:

```sh
conda env create -f basic.yaml --strict-channel-priority
conda activate snakemake
```

## Running Snakemake

Make `00_example` the working directory to run the snakefiles.

Getting snakemake to run is as simple as `snakemake --cores 1`. When running
`snakemake --cores 1`, Snakemake looks for `Snakefile` somewhere in the working
directory and runs it with one core. The number of cores specifies the maximum
number of cores allowed for the run.
> Note: `snakemake -c 1` == `snakemake --cores 1`

- Try the following command. This will run `Snakefile` and produce a file call
  `hello.txt` in the results directory containing "hello world".

    ```sh
    snakemake -c 1
    ```

A specific snakefile can be run using `snakemake -c 1 -s <snakefile>`.
`<snakefile>` is a placeholder for the name of the snakefile.
> Note: `snakemake -s <snakefile>` == `snakemake --snakefile <snakefile>`

- Try the following command. This will create a different file called
  `greetings.txt` in the results directory containing "greetings from a
  different snakefile".

    ```sh
    snakemake -c 1 -s 0.1_snakefile
    ```

## Basics of Snakemake Rules

In order to get a rule to work, there has to be two directives that have to be
present. Directives are indicated by an indent followed by the direcitve and a
colon. As seen in `Snakefile`, the two required directives are `output` and
`shell`. `output` specifies the path of the output file. `shell` runs a shell
command.

The `output` directive is where the path of the output file is specified. The
path and the name of the output is specified as a string. If multiple outputs
are specified, they are in different strings separated by a comma. The different
outputs can also be assigned to a variable so they can be specifically
referenced later on.

The shell commands that is run on the `shell` can either be a single line string
or a multiline string. A single line string is enclosed in quotes, as seen in
`Snakefile`, and a multiline string is used indicated by the triple quotes in
the first and last line of the shell directive. Single line strings can be
useful for running a single short command. Multiline strings are useful for
executing multiple commands and organizing long commands.

- Look at `0.2_snakefile`. It uses a multiline string in the shell directive to
  run `echo` and `cat`.

- Look at `0.3_snakefile`. It uses a multiline string in the shell directive to
  run a long `echo` command.

Accessing other directives in the shell directory uses the syntax `{<name of
directive>}`. When there are multiple outputs, they can be accessed with the
syntax `{output[<index>]}`. The index is the same as python, so `{output[0]}`
corresponds to the first output. In the case where there is a variable assigned
in the directive,the syntax for accessing the variable is
`{<directive>.<variable>}`.

- Look at `0.4_snakefile`. It accesses the first output, `results/out1.txt`, by
  using `{output[0]}` and the second output, `results/out2.txt`, by using
  `{output[1]}`

- Look at `0.5_snakefile`. It accesses the different outputs with
  `{output.file_1}` and `{output.file_2}`.

# 01_example: Basic Directives

## Goals

- Learn the basics of important directives
- Able to create and run Snakemake rules with what you have learned so far

## Examples and Explanations

Remember that running a snakefile is `snakemake -c 1 -s <snakefile>`. Feel free
to try running any of the snakefile examples even if not explictly told to do
so.

Make `01_example` the working directory to run the snakefiles.

### input directive

The input directive is where the path to any inputs for the rule goes. Just like
the output directive, the paths to the input files or directories are given in
as a string. Multiple inputs are given as strings separated by commas. When an
input is assigned to a variable, only the path and the name of the input is in
string format. Access to the input is the same as accessing multiple outputs
from the output directive.
> The syntax is `{input[<input_index>]}` and `{input.<var_input_name>}`.

- See `1.0_snakefile`. This has a singular input as a string.

- See `1.1_snakefile`. This has multiple inputs as strings separated by commas.
  Notice how one of the inputs is a directory.

- See `1.2_snakefile`. This has multiple inputs and these inputs are assigned to
  a variable. Take note on how they are called on in the shell directive.

### output directive

The basics of the output directive have already been covered in `00_example`.
One aspect not covered in the previous example is how Snakemake handles
directories as outputs. Directories as outputs need to specified with this
syntax `directory('<path to dir>')`.
> Note: Snakemake does not check to see if the directory is populated with file,
> but only checks for the existance of the directory. This is important later
> when creating more complex workflows.

- See `1.3_snakefile`. This is an example of having a directory as an output.

### shell directive

All the basics have already been covered in the previous example.

Remember these things.
- Commands must be a string. 
- Accessing other directives in the shell directive uses the syntax
  `{<directive>[<index>]}`.
- Accessing directive variables uses `{<directive>.<variable>}`.

### run directive

The run directive runs a python command. There are a couple major differences
between the run and shell directives. The first difference is the format of the
directive. The shell directive looks for a string to run, whereas the run
directive's python command is not a string. 

- See `1.4_snakefile`. Both rules do the same thing, but the syntax is different
  because of the directive used to create the output.
    > If you noticed how `rule run_directive` is the only rule ran, this has to
    > do with snakemake targets. This will be discussed in `03_example`.

Another major difference is how contents of other directives are stored in the
run directive making the syntax different between these directives. In the shell
directive, all the contents of another directive turns into a string, but the
run directive stores the contents as in a separate Snakemake container. In order
to get a string, the content needs to be referenced as an element of the
Snakemake container.

- See `1.5_snakefile`. This file shows how the `output` directive is used in the
  `run` directive as both a Snakemake container and a string. When this file is
  ran, the types of each variant will be shown.
    > This class distinction is the reason using `with open()` needs the
    > `output[0]` even though there is only one file in output.

- See `1.6_snakefile`. This shows how the first and second file is accessed from
  the output directive in the run directive.

- See `1.7_snakefile`. This shows how the run directive can access files that
  have been assigned to a variable.

### script directive

The script directive runs a python script. The script can access the different
directives in the rule with the same syntax as the run directive with the
addition of `snakemake.` at the front of the directive.

- Look at `1.8_snakefile` and `ex_py_script.py`. The snakefile uses the script
  directive to access the python script. The python script accesses both the
  input and output directive from the rule. Notice how it uses `snakemake.input`
  instead of `input`.

# 02_example: Logs, Conda, Params

## Goal

- Introduce other directives that are useful for Snakemake rules in local runs

## Examples and Explanations

All examples can be ran with `snakemake -c 1 -s <snakefile>`.

Make `02_example` your working directory to run the files.

### log directive

The log directive is used to save the standard outputs (stdout) and standard
error (stderr) of the rule into a file. Having this directive does not
automatically save the stdout of the rule and its commands. This directive can
be treated similarly to the input and output directives. They are all called on
in the same way, and they can use variables in the directive. Typically, stdout
files are stored in a log folder with the `.out` file extention, and stderr
files are stored also in the same log folder with the `.err` file extention.

- See `2.0_snakemake`. The log directive contains the log file as a string. The
  log file is accessed with `{log}` in the shell directive.
    > Note: To access the log file in run directive or in a python script, use
    > `log[0]`.

- See `2.1_snakemake`. This log directive makes use of variables to capture both
  the standard output and standard error. The log files are accessed with
  `{log.stdout}` and `{log.stderr}` in the shell directive.
    > Note: To access the log files in the run directive, use `log.stderr` and
    > `log.stderr`.

### conda directive

The conda dirrective is used to specify a conda environment to run the rule in.
The environment is in `.yaml` format and is written as a string in the conda
directive. In order to use any conda environment in any rule, `--use-conda` flag
__must__ be used in the snakemake command.

- See `2.2_snakefile`. This is an example of what a rule with the conda
  directive would like.

- The following command will run `2.2_snakefile` with the conda environment.

    ```sh
    snakemake -c 1 -s 2.2_snakefile --use-conda
    ```

Conda environments can also be created separately from running the file with the
`--conda-create-envs-only` flag. When only creating the conda environments,
`--use-conda` is not needed.

### params directive

The params directive is useful for specifying options. The main usage is to
organize larger commands for easier customization and increased readability.

- See `2.3_snakefile`. The params directive is used to specify which codon is
  searched for in the grep command.

# 03_example: Target rule and rule all

## Goals

- Explore what a target rule is and why it is important for the function of a
  workflow
- Learn about `rule all`

## Examples and Explanations

Make `03_example` your working directory to run the example files.

### Target rule

When Snakemake runs, it first looks for a target rule. This is the rule that
acts as a goal for the workflow. There are three overall ways to set a target
rule.

The first and easier way to set a target rule is the order of the rules. The
rule that comes first on a snakefile will default be set as the target rule.

- Try the following command. This will only produce `first.txt` even though
  there is a second rule that produces `second.txt` because `rule first` is the
  top rule of the snakefile.

    ```sh
    snakemake -c 1 -s 3.0_snakefile
    ```

- Now try the following command. This will produce `second.txt` because `rule
  second` is at the top of the snakefile in `3.1_snakefile`.

    ```sh
    snakemake -c 1 -s 3.1_snakefile
    ```

The second method to set a target through the command line when the snakemake
command is ran. The available target rules can be displayed with the
`--list-target-rules` flag or `-lt`. The target can be choosen by naming the
target rule in the command.

- Try following command. This command will list all the possible target rules.
    
    ```sh
    snakemake -s 3.2_snakefile -lt
    ```

- Now try the following command. This will produce `3.2_grep.txt` in the `results`
  folder, and this will avoid the other rules in the snakefile.

    ```sh
    snakemake -c 1 -s 3.2_snakefile grep
    ```

A rule output can also be named as a target in the command line.

- The following command will run `rule echo` because the rule's output is named
  as the target.

    ```sh
    snakemake -c 1 -s 3.2_snakefile results/3.2_echo.txt
    ```

The third way to set a target rule is using the `default_target` directive and
setting it to `True`.

- Try the following command. This file should only produce `3.3_echo.txt` in
  `results` folder.

    ```sh
    snakemake -c 1 -s 3.3_snakefile
    ```

- Try the following command. This is produces `results/3.3_grep.txt` because
  rule grep becomes the target when it was called in the command.

    ```sh
    snakemake -c 1 -s 3.3_snakefile grep
    ```

Out of the three methods, the priority Snakemake uses is as follows, the command
line target, `default_target` directive, and lastly, the top rule in the file.

There is sort of a fourth method that almost all proper Snakemake workflows use,
but it is really an organized variation of the first method. This is the usage
of `rule all`.

### rule all

`rule all` is a special rule because Snakemake workflows that follow best
practices uses this rule. This rule is the first rule of the snakefile.Normally,
input is the only directive used in rule all. The files specified in the input
directive of rule all are deemed as targets.

- See `3.4_snakefile`. Notice how `rule all` only has the input directive and
  the target file is `results/3.4_grep.txt`. Based on the target, Snakemake is
  going to look for rule that produces that file and run it.

- Now try the command below. Notice how the target file is produced from rule
  grep and rule touch is skipped.

    ```sh
    snakemake -c 1 -s 3.4_snakefile
    ```

- Try the command below. Notice how rule grep is skipped and rule touch is ran.
  This is because the target from rule all is found in rule touch so Snakemake
  runs this rule.

    ```sh
    snakemake -c 1 -s 3.5_snakefile
    ```

Another way to think about the interaction between rule all and subsequent rules
is that Snakemake tries to match the input of rule all with the outputs of other
rules. Based on how they match up, Snakemake will run the rules with the
matching outputs. Congratulations, you have combined two rules to run with one
Snakemake run.

# 04_example: Creating a Simple Workflow

## Goals

- Introduce simple ways to organize workflow
- Create simple workflows by chaining multiple rules to run together

## Organization

In workflows, organization is key to creating massive workflows that stays
understandable and user friendly. Creating folders to keep inputs and outputs is
one way to do this. As seen before, the `results` folder holds the majority of
the outputs made from rules, and logs holds the `logs` for the rules when the
log directory is used. The new folder introduced in this example is the
`resources` folder.

The `resources` folder holds the files that is used as inputs for rules to use.
Rules can have outputs that produce files in the resources folder that is then
used by subsequent rules to produce results. One way to think about which folder
to put files in is to ask whether the contents of the file achieve the goal of
the workflow, or are the contents a tool used by other rules to produce results.
If the file is achieves the goal of the workflow, consider putting it in
`results`. If the file is used as a tool, consider putting it in `resources`.

## Examples and Explanations

Make `04_example` the working directory to run the examples.

### Bare Bones

To reiterate what has been said in previous example, using `rule all` is
recommended to follow Snakemake best practices. Snakemake will match the inputs
of the target rule, usually `rule all` in proper workflows, with the outputs of
other rules. Then it will run the rules needed to produce the files specified in
the target rule input.

- See `4.0_snakefile`. `rule all` asks for `results/in_and_out.txt` and
  Snakemake finds that `rule in_and_out` has that file in its output directive.
  So it runs `rule in_and_out` to fulfill `rule all`.

### Chaining Multiple Rules

Snakemake will automatically create an order for which rules run. This is called
a Directed Acyclic Graph (DAG). This is the thing that tells Snakemake what
needs to be produced and in which order. This is how it matches inputs with
outputs. Snakemake also has the ability to see which files already exist and
skip the rule that creates the file so that there is no redundancy. Take note
that Snakemake only looks for the existance of the file and not the contents.

- See `4.1_snakefile`. The output of `rule part1` match with the input of `rule
  part2`. So `rule part1` will run before `rule part2`. The output of `rule
  part2` matches with `rule all`. So `rule part2` will run to satisfy `rule
  all`.

- Run the following command to run the workflow.

    ```sh
    snakemake -c 1 -s 4.1_snakefile
    ```

- See `4.2_snakefile`. `rule part1` is the same as in `4.1_snakefile`. Assuming
  `4.1_snakefile` was ran before `4.2_snakefile`, Snakemake will skip the
  running of `rule part1` because the input of `rule part3` already exists. In
  fact, `4.2_snakefile` will work without `rule part1`.

- Run the following command and pay attention which rules run.

    ```sh
    snakemake -c 1 -s 4.2_snakefile
    ```

By having the right inputs and outputs, Snakemake is able to run all the
necessary rules to complete the target.

# 05_example: Config Files

## Goals

- Explore config files and what they can do for a workflow
- Look at how config files are organized

## Explanations and Examples

Make `05_example` the working directory to run these example files.

### Config Files

Config files are usually stored in a folder called `config` according to
Snakemake best practices.

The two most popular methods for accessing a config file in a snakefile is
either through the command line or inside the snakefile.

Accessing the config file using the command line requires the `--configfile`
flag followed by the path to the config file. To use the different values in the
config file, this syntax can be used in any directive `config['<key>']`.

- Try the following command. This should produce `results/config_test.txt` where
  it accesses the message in `5.0_config.yaml` and writes the message in the
  text file.

    ```sh
    snakemake -c 1 -s 5.0_snakefile --configfile config/5.0_config.yaml
    ```

- See `5.0_snakefile` and `config/5.0_config.yaml`. Notice how the key inside of
  the config file are accessed in the snakefile.

The second way to access a config file is from within the snakefile. At the top
of the snakefile `configfile: <path to file>` can be used to access the file.
The keys in the config file can be used the same way as before with this syntax
`config['<key>']`.

- See `5.1_snakefile`. Biggest thing to note is the syntax to access the config
  file at the top of the file. Notice how the path is in string format.
- Try the command below. This should produce a text file containing the message
  that is in `config/5.1_config.yaml`.

    ```sh
    snakemake -c 1 -s 5.1_snakefile
    ```

These next examples will showcase how there can be multiple keys in a config
file, multiple values in the associate with a key, and a key nested within a
key.

- See `5.2_snakefile` and `5.2_config.yaml`. Notice how the config file contains
  multiple keys. The config keys are able to be accessed by stating the key in
  the a bracket after calling config.

- Run the following command to see `5.2_snakefile` in action.

    ```sh
    snakemake -c 1 -s 5.2_snakefile
    ```

- `5.3_config.yaml` and `5.4_config.yaml`. They are the identical. This is done
  to avoid confusion when being accessed by their respective snakefiles.

- See `5.3_snakefile` and try `snakemake -c 1 -s 5.3_snakefile`. This example
  rule writes all the different messages in the config file in a list format to
  a file. This is intended to show how all the values can be accessed at once.

- See `5.4_snakefile` and try `snakemake -c 1 -s 5.4_snakefile`. This example
  rule writes each individual message in the config file as separate lines to a
  file. This is intended to show one way to access individual values from a
  config file.

- See `5.5_snakefile` and `5.5_config.yaml`. This example produces a tab
  separated table of the dessert rating by a family. This is intended to show
  how a config file can have keys that are nested in another key. Also, this
  shows one method to access these nested keys and their corresponding values.

# 06_example: Wildcards

## Goals

- Learn about what a wildcard is in Snakemake
- Explore the uses of wildcards for workflows

## Examples and Explanations

### Wildcards

Wildcards are a built in feature of Snakemake that allow workflows to be
flexible and reusable. They allow directives to have placeholder variables that
can later be assigned with a rule, a list, or config file. This allows Snakemake
to run the same rules but with different inputs or outputs, and allows for the
same rules to run in parallel.

Wildcards can act as placeholders for directives so that one rule is able to
produce identical outputs with different names.

- See `6.0_snakefile`. When this file runs, it will produce 2 identical files
  with different names. Notice how these files are created all from one rule.

- Run the following command and pay attention to how `rule touch` runs twice.

    ```sh
    snakemake -c 1 -s 6.0_snakefile
    ```

Snakemake will know which rules to run for each file just by the matching the
names with outputs names even if the output names contains wildcards.

- See `6.1_snakefile`. There are 4 different files that are created with 2
  different rules. Snakemake can see that the beginnings of each input file is
  the same, `results/6.1_`. So far, all the inputs match both outputs of the
  rules. So the distinguishing difference are the endings, `_msg1.txt` or
  `_msg2.txt`. This is how Snakemake can tell which rule makes which input file.
  Then the file number just distinguishes each input file from one another.

- Run the following command and pay attention to the rules Snakemake runs and
  the outputs Snakemake says each rule should produce.

    ```sh
    snakemake -c 1 -s 6.1_snakefile
    ```

Assigning wildcards using a list or config file requires the use of the
`expand()` function. This function takes multiple variables and replaces them
with the wildcards to achieve the same effect of creating the same files with
different names.

When using a list to assign wildcards. The list is just python code and format.
In fact, as much python code as you like can be written before the rules. You
can test this out with any of the rules in the previous SnakeHive examples, or
you can write your own snakefile to test this.

- Look at `6.2_snakefile`. This contains an example of the syntax for the expand
  function. The path of the file is a string, `'results/6.2_{letter}.txt'`.
  Wherever the wildcard is in the file path, a name for the wildcard is put
  there encased in curly brackets, `{letter}`. Then after the file path, the
  wildcard has to be assigned. That is what `letter=samples` does. In this case
  `samples` is a list. After running the expand function, Snakemake will
  effectively run the following files.

	```
	results/6.2_a.txt
	results/6.2_b.txt
	results/6.2_c.txt
	```

- Try it with the following command and notice the files Snakemake plans to
  create during the run.

	```sh
	snakemake -c 1 -s 6.2_snakefile
	```

Using a config file is very similar to using a list. The only difference is the
need for accessing the config file and using the right syntax when calling the
contents.

- See `6.3_snakefile`. This example has the same functions as `6.2_snakefile`.
  The difference is it uses a config file instead of a list to assign the
  wildcards.

- Try it with the following command and compare the run to the previous example.

	```sh
	snakemake -c 1 -s 6.3_snakefile
	```

Wildcards are not restricted to just the input and output directives. It can
also be used in the shell directive. The syntax is a bit different with
`wildcards.` added before the wildcard is called in the shell directive.

- See `6.4_snakefile`. This example showcases the syntax for using wildcards in
  the shell directive `{wildcards.status}`. Notice how this is different from
  the input and output directive `{status}`.

One of the great things about wildcards is the ability to use multiple wildcards
in one rule. Snakemake is able to produce all the possible combinations of
wildcards.

- See `6.5_snakefile`. The biggest thing to note here is how each wildcard used
  in the expand function needs to be assigned to a list of values.

- See `config/6.5_config.yaml`. Notice how there are 2 values for each of the
  intended wildcards. So at the end, there should be 4 total uniquely labeled
  files.

- Try the following command. This example should produce 4 unique files. When
  looking at the snakemake logs that appear when running snakemake, it should
  say 5 jobs were completed because of rule all.

    ```sh
    snakemake -c 1 -s 6.5_snakefile
    ```

The last example shows off how snakemake can run these rules in parallel with
each other. This is done by increasing the number cores Snakemake is allowed to
use.

- Try the following command. Paying attention to the Snakemake as it runs, it
  will echo which file it will work on and when its finished. The workflow is
  designed to pause before creating a the file and after creating the file so it
  is easier to read in real time.

    ```sh
    snakemake -c 2 -s 6.6_snakefile
    ```

	> The number of cores can be changed and increased to see this happening
	> quicker. Specifying more cores than your machine has can reduce the
	> performance of your machine.

# 07_example: Modules

## Goal

- Explore how modules help with workflow organization and flexability

## Explanations and Examples

Make `07_example` the working directory to run the example files with the
recommended commands.

### What is a Module

Module is a method of accessing other snakefiles from another snakefile. This
allows either the whole snakefile or specific rules to be used in other parts of
the snakefile. This is useful for creating a toolbox of rules for your workflow.
For example, a rule that checks the resource usage of another rule would be
something that can be implemented multiple times in a workflow. Another usage
for using modules is being able to use rules between different projects.
Separating rules can also help with organizing parts of a pipeline.

### Organization

Usually, snakefiles that are not the main snakefile are put into a folder called
`rules`. They also have the `.smk` extention. This is so that the rules are
organized in a large workflow where there can be many different snakefiles each
with many rules. Having lots of files in the working directory can make it hard
for newer users to use the workflow, and the clutter makes it harder to find
specific files.

- See `rules` folder. The snakefiles in there all have the `.smk` extention.

### How to Use Modules

Modules have a similar structure to rules, but the differences come in the
directives and an extra line at the end. The first line of a module is `module
<name of the module>`. The name of the module can be anything and does not have
to be associated with the snakefile it will reference. Following the naming of
the module, the `snakefile` directive is typically used to specify the path of
the snakefile that the module will pull from. After all the modules are
specified, the rules from each module has to be stated. The syntax for this is
`use rule <rule name> from <name of module>`. Modules allow for rules to be
selected from a snakefile allowing for finer control over what goes into a
workflow.

- See `7.0_snakefile`. Just like with any workflow, rule all is used as the
  target rule. Then `rules/touch.smk` is imported in as a module. Then it
  specifies that it wants to use rule touch from within the `make_file` module.

- Try the following command to see how `rule touch` from `rules/touch.smk` is
  used seamlessly in the example.

	```sh
	snakemake -c 1 -s 7.0_snakefile
	```

These examples will showcase some of the use cases of modules. All of these
examples will pull from the same snakefiles in the rules folder.

- See `7.1_snakefile` and try `snakemake -c 1 -s 7.1_snakefile`. This snakefile
  is an example of how to use two rules from two different modules.

- See `7.2_snakefile` and try `snakemake -c 1 -s 7.2_snakefile`. This snakefile
  showcases how a single rule from a module containing multiple rules can be
  used.

- See `7.3_snakefile` and try `snakemake -c 1 -s 7.3_snakefile`. This example
  showcases one method for accessing multiple rules inside of module containing
  multiple rules. This has the same function as `7.1_snakefile` where it uses
  multiple rules.

- See `7.4_snakefile` and try `snakemake -c 1 -s 7.4_snakefile`. This example
  shows a method for accessing all the rules in a module. This is useful for
  when the whole module is used and it contains multiple rules.

Another important directive for modules is the config directive. This gives the
module snakefile access to a config file. It is the same as specifying
`configfile: <name of config>` at the top of of the snakefile. However, using
the config directive for a module allows the module snakefile to have the
flexiblity to have different configs without requiring the use to go into each
snakefile and manually input the config.

In order to use a config file in modules, a config file has to be set in the
main snakefile through any of the methods discussed in the config file section
`05_example`. Then `config` can be put into the `config:` directive. This works
because the contents of a config file is set to `config` variable by default.

- See `7.5_snakefile` and `7.6_snakefile`. The big thing to note in these
  functionally same snakefiles is how config is used in the module.

- Now try the following commands. The differences in the contents of the two
  output files is due to the differences of the config file. This is a great
  example of how a workflow can be reused by simply changing the config file.

	```sh
	snakemake -c 1 -s 7.5_snakefile
	snakemake -c 1 -s 7.6_snakefile
	```

# 08_example: Profiles

## Goals:

- Learn about profiles and how they help with running a worflow
- Introduce organization for profiles

## Explanations and Examples

Make `08_example` the working directory to run the example with the recommended
commands.

### Profiles

Profiles allows the Snakemake run command to be shorter. It allows all the
options to be put into a yaml file. It also makes it easy to run the workflow
with different options without having to type out the whole command each time.
> This is most apparent later on in the example pipelines in `13_example`.

Snakemake recognizes a specific format to run a profile. There has to be a
directory with specifically `config.yaml` in that directory. The name of the
directory does not matter for function, but it should be descriptive of how the
workflow is run. `config.yaml` that lives inside of the profile direcory has to
be exactly `config.yaml` because Snakemake will look for this file when running
a profile to determine the options and flags used in the run.

- See `run_8.0/config.yaml`. Notice how the name of the profile is descriptive.
  The file inside of the directory is exactly `config.yaml`. The options that
  would be noramlly used is in the config file.

- Try the following shell command. This is the same as running `snakemake -c 1
  -s 8.0_snakefile`. This is the syntax for running a profile.

    ```sh
    snakemake --profile run_8.0
    ```

Target rules can also be specified in the profile config file. Normally on the
command line, the target rule is just stated at the end of command by itself
with no flag. This cannot be replicated in the config file, so the workaround is
to use the `--until` flag. This flag will complete the workflow until the
specified target rule. This is not used much as anything that is designed to
change should be in a config file that the snakefile reads.

- See `run_8.1/config.yaml`. This profile config file uses the until flag to
  target rule touch. The target can be changed to any rule in the snakefile. >
	> Reminder that `snakemake -s 8.1_snakefile -lt` can be used to check
	> possible target rules.

- Try the following command. This will produce the output of the target rule set
  in the profile config.

    ```sh
    snakemake --profile run_8.1
    ```

	> Same as running `snakemake -c 1 -s 8.1_snakefile touch`.

Profiles are also able to include conda environment usage. There can be one
profile to just create conda environments, and there can be another profile to
run the snakefile. This is useful later on in resource management.

- See `conda_8.2`. This profile is set up to only create conda environments for
  `8.2_snakefile`. It is best practice to create the conda environments
  separately from running the snakefile when running on clusters.

- See `run_8.2`. This profile is set up to run `8.2_snakefile` with conda
  environments.
	> Running this will also create the conda environment if not already made.

## Organization

Profiles are put into a folder depending on its purpose. If the profile is set
up for local execution, then an appropriate name could be `local`. If a profile
is set up for slurm execution, then `slurm` could be an appropriate name.

# 09_example: Putting Together a Workflow

## Goals

- Learn how to organize a whole workflow
- Showcase what a proper organized workflow could look like

## Organization

One thing to keep in mind with organization is that its purpose is to make it
the workflow easier to use for users and easier to edit if needed. The best
organization is one that is simplest. However, the organizational structure is
best practices for Snakemake and is intended to accomodate larger and more
complicated workflows with more parts.

The first level of this organization structure contains config, resources,
results, workflow, and the profiles. The choice to leave profiles at the first
level is supposed to make it easier to run the workflow on the command line.
`workflow` contains everything that is needed to do work for the pipeline. The
contents of the workflow directory is not intended to be editted by the users.
Users are intended to interact with the config, resources, and results
directory.

- `config`: This is where users change how the workflow behaves. For this
  example, the config is where the codons that are meant to be searched are
  listed and the path to the genome.

- `resources`: This is where the user would populate the input files. For this
  example, this is where the genome is stored.

- `results`: This is where the end results of the workflow go. For this example,
  a file with the input and output of rule script and all the codon counts get
  populated in this directory once the workflow finishes.

There are two profiles for this example. `only_conda` is meant to only download
conda environments. `run_ex` runs this example. The separation of the two is
important later when working with the cluster.

The only directory in this organizational structure that has more levels is
`workflow`. This directory is where all the computation happens.

- `Snakefile` is the main snakefile that controls the workflow. It is important
  to that the main snakefile is name `Snakefile` because that is the default
  snakefile that Snakemake looks for when not given a specific snakefile.

- `envs`: This contains all the instructions for the conda environments used in
  the workflow. For this example, the only conda environment contains the
  usr/bin/time version of time.

- `logs`: This directory contains all the logs that is produced by the
  snakefiles. Logs are not in the first level because it is not usually
  interesting for users when there is no issues. In this example, the log
  contains the resources rule codon uses.

- `rules`: This contains all the other snakefiles that is not the main one. In
  this example, two other snakefiles are used by modules in the main snakefile.

- `scripts`: This is where all the scripts used in rules reside. In this
  example, only one rule uses a script so only one script is in the directory.

With everything discussed up until this point. You should be able to start
creating Snakemake workflows and running them locally. The later examples will
go over how to properly use Snakemake with Hive.

# 10_example: Basics for Running Snakemake on Hive

## Goals

- Learn the Hive basics
- Get familiar with the a SLURM script
- Run basic Snakemake on Hive

## Getting access to Hive

For the purposes of this tutorial

## Using Hive as a remote desktop

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
squeue -u $USER
```

- `-u` flag is for seeing jobs from a particular user, other flags can be seen with the following command used in the terminal.

    ```sh
    squeue --help
    ```

- Tip: The following command will allow `squeue -u $USER` to run every second essentially allowing you to keep track of your jobs in real time without having to rerun `squeue`. Use `ctrl + c` to cancel the command.

    ```sh
    watch -n 1 "squeue -u $USER"
    ```

Another useful slurm command is `scancel`. This followed by a jobid allows a specific job to be terminated. The different `scancel` options can be viewed with the help page, with the command shown below.

```sh
scancel --help
```

Run the following command that will run a slurm script which will result in `hello world` printed to `results/hello.txt`.

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

There are two ways to use Snakemake on Hive. The first way is to run Snakemake through an interactive session. This is similar to how you would run Snakemake locally on a local machine. This is only encourage to test small workflows because an interactive session should use a small portion of the cluster's resources. The second way to run Snakemake is through submitting a job through sbatch. This allows the resources for the job to be set separate from the interactive session.

Submitting a Snakemake job requires a conda environment containing snakemake to be used in the sbatch script. The conda environment is best made beforehand manually in an interactive session. This is mainly due to the resources it would take to make a conda environment versus the resources it would take to run the Snakemake workflow. The resources that would need to be requested in the sbatch script would be wasted after the conda environment is created. This is seen in the rest of the workflows that use conda environments later on.

In the interactive terminal run the following to download a basic snakemake conda environment for Hive. I am assuming you are in the same directory that contains `snakehive.yaml`.

```sh
conda env create -f snakehive.yaml --strict-channel-priority
```

After creating the conda environment, Snakemake can be used in the sbatch script by first activating the environment in the script. This can be seen in `10.2_ex.slurm` after conda is loaded.

There are technically three flags that are required to running Snakemake and getting it to submit its own jobs to the cluster. There is one flag that is not required but essential. Lastly, there is one flag used for convience.

- `--jobs` is the number of jobs Snakemake is allowed to request from the cluster at a time.
- `--executor` specifies which job manager to use when submitting jobs.
- `--default-resources` specifes the default resources Snakemake will use if none is given. The essentials for default resources are `slurm_account` and `runtime`. However, `threads` (number of cpus), `mem_mb` (memory in megabytes), and `slurm_partition` should be added as default resources as well. The defaults if not given are 1 thread, 1000 mb of memory, and high partition.

`--latency-wait` might not be a required flag but it is essential. This is the amount of time Snakemake will wait for a file to appear in the system before marking the it as missing. This is needed on clusters because there can be a delay between when a file is made and when it appear visible on the system.

The example can be run with the follow command:

```sh
sbatch 10.2_ex.slurm
```

# 11_example: Resource Management for Workflows on HIVE

## Goals

- Explore why resource management is important on the cluster
- Explore ways to test for the minimum required resources
- Give example of how Snakemake can submit multiple jobs

## Importance of resource management

A crucial part of running any workflow on a cluster is resource management because resources are shared so occupying unused resources prevents fellow researchers from also using the cluster. Additionally, requesting large amount of resources can cause your workflow to be lower on the queue so it can take longer to run. The best solutions to this are requesting the minimum amount needed to run the workflow, and split up larger workflows into smaller jobs.

## Testing for minimum resource requirement

Running a job on the cluster often takes varying resource amounts. The simplest way to find the amount of resources is by running a workflow multiple times and using the `sacct` command. This is easier than checking the output of the job, but doing so it also another way to get the resources used by a job.
- `--forceall` flag is a great tool to use to force snakemake the run the whole workflow even if the outputs are present. It is used in resources testing so that the outputs do not have to be manually deleted every run.

### Setting the resources for a slurm script

Run the following command three times and only run the next iteration when the previous one is finished. When you see the name `11.0_ex` complete, then run the `sbatch` command again.

```sh
sbatch 11.0_ex.slurm
```

The progress of the workflow can be checked with the following command. `11.0_ex` is complete it disappears from the `squeue` screen.

```sh
squeue -u $USER
```

One tip for using squeue is that you can run the following command on a separate terminal. This will rerun the `squeue` command every second automatically giving you live updates on the jobs running under your username.

```sh
watch -n 1 "squeue -u $USER"
```

The first thing you want to look for is to make sure the job state says completed. Then the maximum memory used can be seen with the follow command. You are looking first for the JobName of `11.0_ex`. Under that name, `batch` will be the sub job that actually uses the resources and that can be seen under the `MaxRss` column. Another way to identify the maximum memory used for a job is to look at the JobID. The `<jobid>.bat+` JobID will be the one that actually uses the resources.

```sh
sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state
```

After running `11.0_ex.slurm` three times, the highest MaxRss, same as maximum amount of memory used, is `145608K`. This means that out of the three runs, the highest amount of memory used was about 150MB. The memory on the slurm script will now be set to 200MB so that there is enough of a buffer incase the script requires more than 150MB. Look into `11.1_ex.slurm` to see the change on line 8.

To double check, run the following command three times and waiting for the job to finish before submitting the next.

```sh
sbatch 11.1_ex.slurm
```

Check the MaxRss with the following command. Make sure the job state is completed.

```sh
sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state,alloccpus
```

The amount of requested memory can be changed in a slurm script so that the script still runs but you are not occupying unused resources.

### Controlling Snakemake resources in a slurm script

The default resources for a job Snakemake submits is separate from the resources that the slurm script that runs the Snakemake program.

The default resources for a Snakemake submitted job is 1 core with 1GB of
memory. For the purposes of these examples, the rules will rarely need that much
memory, so it is a waste to tie up 1GB of memory when the workflow does not need
it.

The way to control the default resources Snakemake is allowed to request is through the `--default-resources` flag. Similar to the existing variables that already exist from the previous examples, there are other variables that control the default resources.

- `slurm_account=publicgrp` essential to get Snakemake to submit jobs. Controls the account the job is submitted under. In this case, the account is publicgrp, but other accounts can be used if you have access.

- `runtime=3` essential for getting Snakemake to submit jobs. This sets a limit to how long a job is allowed to run. In this case, the job will have to finish with 3 minutes.

- `slurm_partition=low` not essential but should be used. This sets the priority of the job. In this case, the parition is set to low.

- `mem_mb=200` is the amount of memory Snakemake will request for a job. In
this case, Snakemake is asking for 200MB for every job it request. This number 
was found by running `11.2_ex.slurm` and checking the amount of memory used 
with the following command.

    ```sh
    sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state,alloccpus
    ```

    - Note that Snakemake submitted jobs will have a job name containing a
      generate string. The best way to identify which jobs are the Snakemake
      submitted ones are by checking the slurm logs that appear in the `jobs`
      directory to get the job ID of the Snakemake jobs, or they should appear
      below the job name `11.2_ex` with a generated job name assuming no other
      jobs are submitted by you before this one finishes.

## Breaking up larger workflows

One of the biggest features of Snakemake is being able to have different resources for different parts of the workflow while still being able to run the whole workflow at once. This is why using the default resources to control the resources that Snakemake can request for a job should be used as a backup for when Snakemake rules do not contain their own specified resources.

### Controlling resources on a per rule basis

The `resources` directive along with the `threads` directive in rules can be used to specify resources the rule needs to run. The `resources` directive allows the memory and runtime to be specified. Memory is specified through the `mem_mb` variable. This variable takes an integer and specifies how much memory the rule should use in mega bytes. Runtime is specified through the `runtime` variable. This variable takes an integer and specifies the maximum amount time the rule should use in minutes. The `threads` directive specifies the number of cores the rule should use. More detail later on.

- See `file.smk`. Under the resources directive and on the mem_mb variable, 175 says this rule should only request 175MB of memory.
- See `file.smk`. Under the resources directive and on the runtime variable, 2 says the rule should request 2 minutes of time.

Run the following commands. The commands run a slurm script that allows Snakemake to run file.smk.

```sh
sbatch 11.3_ex.slurm
```

After this finishes, run this to see the resources it requested and used.

```sh
sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state,alloccpus
```

Notice how the resources that Snakemake requests to run file.smk are the resources specified in the rule and not the default resources.

This type of rule level control is what makes Snakemake a great tool to use for a workflow. Different rules can have different resource requirements. `2_rules.smk` has two different rules that each have their own specified requirements. Snakemake will submit these rules as individual jobs and request different resources.

Run the following command and see how Snakemake will submit each rule as separate jobs.

```sh
sbatch 11.4_ex.slurm
```

Run this command after the previous one has finished to see the jobs submitted today by yourself and the resources used.

```sh
sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state,alloccpus
```

Notice how with one run of the slurm script, Snakemake was able to submit two separate jobs each with their own specified resources.

### Threads and the job flag

The number of cpus Snakemake can request is based on the `threads` directive in a rule and the number specified in the `--jobs` flag when running Snakemake initially. Snakemake will always request cpus based on the lowest value of these two.

Run the follow command and see how Snakemake requests 2 cpus even when the initially submitted slurm script only runs with one.

```sh
sbatch 11.5_ex.slurm
```

The following command is run after the previous has finished to see the jobs submitted and the resources.

```sh
sacct -u $USER -S today --format=jobid,jobname,maxrss,reqmem,state,alloccpus
```

- As a side note, more cpus make this rule faster it is for demonstration purposes.

The commands for the rest this subsection is intended to for you to see Snakemake submit jobs in real time. Run this command on a different terminal to see jobs you submit in real time.

```sh
watch -n 1 "squeue -u $USER"
```

Snakemake is also able to submit multiple jobs at the same time and have them all run, as long as the cluster allows it. This is useful for splitting larger workflows up so that they can finish without a different job taking priority of the resources. Splitting larger workflows also allow them to run quicker. This ablility is managed by changing the number attached to the job flag. The way the job flag works is by specifying how many cores Snakemake is allowed to request at a time. So having `--jobs 10` means that Snakemake is allowed to submit ten 1 thread jobs or two 5 thread jobs.

In the following command, it will run the `2_rules.smk` again but it will run both rules at the same time instead of one after another.

```sh
sbatch 11.6_ex.slurm
```

## Automation

There are many ways to automate the process of finding the right amount of resources for a rule in a workflow. Whichever creative way you choose to automate this process, you have to keep in mind the the amount of memory used will change every single time when running it on the cluster.

My perfered method to somewhat automate this process is by running the rules once to get a general idea about how much memory, using the more than the estimate, and lowering the resources until the workflow has just as much as it needs to complete successfully. The part I automate is the end where it runs the workflow dozens of times to check for failure. 

The reason I choose to only automate the end to check is for simplicity. The code is simiple and this method works for all the workflows in this tutorial.

See `11.7_ex.sh`. This shell script has two variables that are meant to be changed. The way that script works is that it run the workflow a number of times one after another after the previous on has completed.

- `num_trials` controls how many times to run the workflow. 
- `script` is the slurm script that runs the workflow. It is important that there is some way for the workflow either bypass the fact that outputs exists already or a way to delete the outputs after each run so that the workflow can run properly. In most of these scripts, `--forceall` is used to force the workflows to run.
- Line 7 is the loop where is `num` starts at 1 and increments by 1.
- Line 8-9 runs the slurm script on the first iteration of the loop. When the script is submitted through `sbatch`, the `--parsable` flag is used so that the job id for can be saved into an array.
- Line 10-12 runs all the iterations that is not the first one. What is does is it used the `--dependency` flag to run only run the next job when the previous one has completed. It does this by waiting for the previous job id to finish.

Try this automation by running this command first on a separate window. This will allow you to see all jobs being queued.

```sh
watch -n 1 "squeue -u $USER"
```

Now run this command and see how it queues up all the jobs at once but only runs them after the previous one has completed

```sh
bash 11.7_ex.sh
```

## Conda resources on Hive

Similarly to running conda in Snakemake locally, conda in Snakemake on Hive needs first installs all conda environments before running the workflow. Generally, it takes a minimum of 2500MB of memory to download just the conda environments for a Snakemake workflow. This can be used a baseline for figuring out how much resources downloading the conda environments will take. The resources it uses are specified in the slurm script and is not the resources specified in rules. So this memory minimum might be way more than is needed to run the slurm script. This results in wasted resources that are not used after the conda environments have been installed. The best way to account for this is to build all the conda environments separately from the workflow by using the `--conda-create-envs-only` flag in the slurm script with the Snakemake command.

- See `11.8_ex.slurm`. This is an example of a slurm script that will download only the conda environments first. Notice how the memory requested is 2500MB.
    - Note: This script will not run and its purpose is for demonstration only.

# 12_example: Slurm Profiles

## Goals

- Explore how profiles can be used in slurm scripts

## Usefulness of Profiles in Slurm 

As stated in previous examples, profiles allow for all Snakemake options to be put in a separate yaml file. This helps with clarity and organization.

You might be asking what is the purpose of using profiles when running slurm scripts because the options can be organized within the slurm script. The two main reasons is formatting and organization.

The format of a yaml file is much cleaner to read and look at versus having all the options as part of the slurm command. This can be seen in the in `12.0_ex.slurm`, `12.1_ex.slurm`, and `12.1_profile/config.yaml`. In 12.0, all the options are laid out with and the command is more difficult to follow. Whereas, 12.1 has the command neatly in the slurm script, and all the options are formatted so they are easy to read in the profile. The yaml formatting also makes it easy to make changes when needed.

Profiles also help with organizations because it easy to have separate options for different jobs. One great example of this involves downloading conda environments separate from running the workflow. In 12.2, the conda environment downloaded and nothing else is run. In 12.3, the workflow is run after the conda environment has already been installed. Notice how the commands for both are similiar. The only difference is which profile it calls for. When you look into `12.2_profile` and `12.3_profile`, the config files for each of those are very different. The separation of the command and the options make it easier for users to read the slurm file and know what command is being run without having to look at the entire command. This also allows users to dive deeper into the code as they see fit.

Something fun about profiles is that it allows you to run a batch script that automates the creation of the conda environments and the running of the workflow while keeping organized. This has the best of both worlds because the entire workflow can be run with one commmand and the resources used are minimum.
- See `12.4_ex.sh`. This script creates a conda environment and also run the workflow after the environment is created. Essentially, it combines `12.2_ex.slurm` and `12.3_ex.slurm`.

# 13_example: More Example Workflows

## Goals:

- Gives some example workflows that follow best practices

## Precursor (need better title)

These examples are meant to show different workflows that get more complicated. All these examples are supposed to follow best practices for Snakemake. 

## local_example

This is an example Snakemake workflow that is designed to run locally. The first step to running this command is make sure you are in the conda environment named `Snakemake`. This is the environment made from `basic.yaml`. The whole workflow can be run with the following command.

```sh
snakemake --profiles local
```

Normally, workflows that use conda environments have a profile that just downloads the environments so to minimize resources usage, but this is not an issue when running locally because the resources are not shared and are only your own.

### config

This folder contains `config.yaml`. This file will contain all the parameters for workflow. In this workflow, the configs inside are just used to control the names of different files. A side note is that the config file inside of this folder does not need to be named `config.yaml`. It can be named whatever you see fit.

### local

This is a profile that also contains `config.yaml` not to be confused with `config/config.yaml`. Profiles must have `config.yaml` inside of them as that is the file that Snakemake is looking for when using profiles. The file contains only `cores` and `use-conda` because it is a local run and the workflow uses a conda environment. This profile effectively translates to the command below.

```sh
snakemake -c 1 --use-conda
```

### resources

The best way to think about this folder is the input folder. This is where all the inputs for the workflow should go.

In this case, all the files needed are generated within the workflow, and this is why this folder is empty.

### results

In contrast with the resources folder, the results folder is the output of the workflow. This is where the desired output files will go.

When a file is both desired as an output and used as an input for another step of the workflow, it is best for that file to be put into the results folder because it is easiest to have one folder with all the files you want to look at.

### test

This is a profile that is intended to test the workflow. It does this by using `forceall` and making the workflow run even if the output files are present.

### workflow

This is where the bulk of the workflow will be. This is not meant for users to change or modify. Controlling the workflow should be done with the config files.

#### envs

This contains all the conda environements that are used in the workflow. Both environments use time so that to measure the resources used by the rule. `mk_sam.yaml` has python because that is what generates the the sam file. `mk_bam.yaml` has samtools because this is used to convert sam files to bam files.

#### logs

This is where the logs of the each rule is directed. The log folder is meant to be used for troubleshooting and development. That is why this lives as a separate folder inside of `worflow` and not put into the result folder.

#### rules

This folder houses all the rules that is used in the workflow. These rules are then used on the master Snakefile.

`mk_bam.smk` converts a sam file to a bam file using samtools. It references the file names specified in the config file. This allows for the names of files to be changed by a user without them going into the workflow.

`mk_sam.smk` runs a python script, that creates a sam file. This also accesses the sam file name from the config file to allow for easy customizability.

#### scripts

The only script this workflow uses is `mk_sam.py`. This script is written so it takes the arguments of the command and uses them to create a sam file and log the run of the script. This script uses `sys` versus using `snakemake` and its built in functions because `sys` allows the script to be used outside of snakemake. This is useful for testing and making it compatible with other workflows.

#### Snakefile

This is the master file for the workflow. Snakemake will look at this file first when it runs. The first thing to do is to specify the config file so that all the rules and the snakefile can access the config. `rule all` is used to specify the desire output for the workflow. Then all the rules that are used are loaded in through modules.

There are two different ways to use rules from a different file. The first is to use `include`. This loads all the rules into the main snakefile as if it was part of the main file. The other method is to use `module`. This uses rules from the other files and allows for more control. Using `module` in complicated workflows allows the rules to work without conflict and allows for finer control over which rules from a file.

`module` is used in this example but is not necessary for simple workflows like this. It is used here to showcase the syntax.

The last thing to note is the how the config file is loaded into a module. `config: config` specifies that the config for this module can be found with the config variable. The config variable stores the configs specified in the beginning of the Snakefile.

## cluster_example

Functionally, there is no difference between this example and `local_example`. The only difference is that this example includes running in the cluster and testing for resource usage.

### mk_envs

This is a profile that only builds the conda environments needed. One thing to note about `config.yaml` in this profile is that it only has 2 options and does not include `cores` or `jobs`. These normally required flags are not needed when using `conda-create-envs-only`. However, `use-conda` is required so that Snakemake knows to look for conda environments in the rules.

> Remember Snakemake looks specifically for `config.yaml` in profiles.

### slurm

This is another profile that is used to run the whole workflow. This profile uses the options `slurm-keep-successful-logs` and `slurm-logdir` to keep the outputs of the Snakemake submitted jobs, which will be the individual rules.

`slurm-keep-successful-logs` tells Snakemake to keep the logs of any rules it runs. Normally, this is false so Snakemake only keeps the logs of failed jobs. This is used to see how much memory the rules themselves use.

`slurm-logdir` tells Snakemake where to put these logs. Without specifying this, the logs will go into `.snakemake/slurm_logs`.

### test

This folder holds all the files used to test workflow for its resource usage.

`envs_trials.sh` queues up the script that installs the environments. The scripts will run one after another but not at the same time.

`get_mem.sh` creates a file `mem_used.txt` that shows the job id, the memory requested, the maximum memory used, and the state of the job. The file separates the jobs for conda environment testing, initiation of the workflow, and the rules that are ran in the workflow. The purpose of this file is for to be able to see how many resources are used at each stage of the workflow.

`test_envs.slurm` is the slurm file that only downloads the environments. What makes this different from the `mk_envs.slurm` is that it will force Snakemake to remake the environments by deleting the save. This allows the resources to be tested multiple times.

`test_workflow.slurm` is the slurm file that forces the workflow to run even if the output files exist. This is also used to test the resources of the workflow.

`workflow_trials.sh` queues up the script that runs the workflow. The script will run one after another waiting for the previous one to finish.

### workflow

The workflow is the same as in `local_example`. The only difference lies in the rules. The rules now have specified resources they can request. This is only needed when running in the cluster because optimizing resource usage is important for quicker runs and sharing resources with others.

### mk_envs.slurm

This script just creates conda environments for the workflow. Note that running this will not recreate conda environments if they already exist. Also notice how this script asks for significantly more memory than other scripts because conda environments take more memory to create.

### run.slurn

This script runs the workflow through and only creates outputs that are not already present in `results`. Note that this script will fail with out of memory if the conda environments are not made beforehand.

## wildcards_example

This example shows off wildcard usage and how multiple threads can be used a real world example with blast.

### config

This config file contains the number of trials that will be performed, the path to the genome, and the specification for the generated reads. These will be referenced throughout the running of the workflow. This is the file that can be changed in order to modify the function of the workflow.

### local

This is a Snakemake profile that runs the workflow locally. Remember that Snakemake profiles require a file named `config.yaml` in order for the profile to work.

### mk_envs

This is also a Snakemake profile that only creates the conda environments. This is useful so that the resources to create the environments and the resources for running the workflow are kept separate.

### resources

This folder contains the inputs needed for the workflow. In the case with this workflow, there will more generated files that will populate this folder as the workflow progresses.

### results

This is the folder where all the desired outputs of the workflow will go.

### slurm

This is a profile that is geared towards running the workflow on the cluster. Notice how this profile allows Snakemake to run 5 jobs at once.

### test

This folder holds all the files needed to run resource testing on the workflow. This folder is the exact same as the one in `cluster_example`.

### workflow

#### envs

This folder contains two environments. One the environments `blast.yaml` has the dependencies blast and time. This is used to run a blast and get the resourcs of that blast run with `time -v`. The other environment 'simple.yaml' just has python. This is used to run a python script.

#### logs

This contains all the logs produced by the workflow. These files are used to catch errors and see the resources that each part of the workflow used.

#### rules

This contains all the Snakefiles that contain the workflow rules. These rules are then loaded in by the master Snakefile to run the workflow. The rules pull from the `resources` folder and use files from `envs` and `scripts`. The outputs can go into `logs`, `resources`, or `results` depending on the purpose of the produced file.

- `blast.smk` contains one rule that runs a blast. This rule contains wildcards indicated by `{}` that allow multiple identical files to be produced by the same rule with one run. This rule is also allowed to use 2 threads so that blast can work faster. Remember this rule will not use multiple threads if the `jobs` is not set more than 1.

- `mk_in.smk` makes the files needed to run the blast. It contains 2 rules. The first rule `get_reads` uses wildcards to create multiple random reads. The second rule `mk_db` makes the blast data base from the genome file.

#### scripts

This folder contains the scripts that are used by the various rules in the `rules` folder.

- `get_read.py` takes in a genome in a gzipped format. Then in outputs a file containing a random number of reads.

#### Snakefile

This is the master Snakefile that controls the workflows. It loads in all the rules it needs gives the rules the desired config file. This Snakefile also uses some python code in order to generate a list of trial numbers so that the list does not have to be manually made in the config file.

### mk_envs.slurm

This slurm file is used with sbatch in the cluster to generate the environments needed for this workflow.

### run.slurm

THis slurm file is used with sbatch to run the workflow on Hive. This jobs will fail if the environments are not downloaded before.

## parallel_runs_example

The purpose of this example is to show how snakemake can run many jobs in parallel and combine them at the end.

### config

This file contains the different parameters that the blast entropy filter uses. There is three parameters each with 3 options. This makes a total of 27 different combinations of possible blast runs.

### local

This is the profile that runs the workflow locally on your machine.

### mk_envs

This is the profile that creates all the conda environments only.

### resources

This is where all the resources for the workflow are. These files are use in the workflow, but these are not the files a user will want as the output.

### results

These are where all the output files of the workflow will go.

### slurm

This is the profile that runs the workflow in Hive.

### test

This folder holds all the files used to automatically test the workflow. This is the same across the previous examples.

### workflow

The major differences between this workflow and `wildcards_example/workflow` are the rules and scripts.

The steps are as follows:
1) Create reads from genome and create blast database from the genome.
2) Blast all the reads to the genome with different entropy filter parameters.
3) Compare the results by counting the number of differences between the blast results.

#### rules

`mk_in.smk` is still the same as the one in `wildcards_example`.

`blast.smk` uses three wildcards in one input line. The creation of these wildcards are in `compare.smk`. `rule blast` is the rule that Snakemake will run in parallel when on the cluster. It is not using more cores per job, but it is submitting multiple jobs at once to allow them to all run at the same time. This can speed up a workflow similar to this that has lots of repetitive tasks that can be done at the same time.

`rule blast_unfiltered` runs blast without an entropy filter. This had to be a separate rule because it used a different syntax to run this option that did not follow the same pattern as the other blast runs.

`compare.smk` collects all the results and compares the results to find differences.

`rule move` is a rule that creates all the wildcards, checks to makes sure all the files are present before moving on the the next step, and moves them all into a new directory. 

One important technical note about Snakemake is that it matches exactly outputs of rules to inputs to other rules. So whenever a directory is specified as an output for a rule and used as an input for a different rule, Snakemake does not check to make sure files are populated in the directory before using it in the input of a rule. This makes it important to add intermediate rules to make sure all the files are present in a directory before the next rules uses that directory.

`rule compare` runs a python program that compares the differences between the files and creates a text file displaying these differences.

#### scripts

The only new script is `compare.py`. This script uses the `diff` command to find the differences in between each of the files and prints it out onto a text file.

#### Snakefile

The notable thing about this Snakefile is that it has one file in `rule all` even though it uses wildcards. Wildcards do not have to be created in the `rule all` level in order to work.

# Template

## Goal

- Act as a simple starting point for a Snakemake pipeline
- Adhere to best practices for Snakemake

## Explanation

`config` holds `config.yaml` where different parameters are put that are used in multiple rules. The name yaml file inside of `config` can be changed

`local` is a Snakemake profile for running the pipeline on your local machine. It contains all the Snakemake run options. Snakemake looks specifically for `config.yaml` when using the `--profile`.

`mk_envs` is also a Snakemake profile but it just build the conda environments. This can also be ran locally on your machine.

`resources` is where all files that are used in the pipeline goes. Files here are not usually the files the user will look at when the pipeline finishes.

`results` is where the results of the workflow go. This is where the user will look for the results of the pipeline.

`slurm` is the profile used in Hive to run the pipeline. This will memory out if the conda environments are not made in advance.

`test` is where all the test scripts live. This is not needed for the workflow, but it is nice to have when developing the workflow. There is probably better ways to test a pipeline and more efficient scripts, but this is what worked for me.

- `get_mem.sh` runs the test with 5 trials each for conda environment creation, running Snakemake, and each rule Snakemake submits to Hive.

`workflow` is where the all the files that get Snakemake pipeline to work go.

`mk_envs.slurm` is the script runs `mk_envs` when submitted to Hive with sbatch.

`run.slurm` is a script that runs `slurm` when submitted to Hive with sbatch.