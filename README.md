SnakeHive
=========
Tutorial and best practices for Snakemake and Hive

## Goals ##

- Minimal pre-installation (snakemake, conda)
- Provide in depth tutorial of how to use Snakemake
- Walk through how to optimally use Snakemake in Hive
- Examples of progressively more sophisticated Snakemake pipelines
- Follow Snakemake best practices

## Getting Started ##

The tutorial starts in the `tutorial` directory. There will be a `README.md` in
that dirctory that will the main file that will walk you through the whole
tutorial. There will be no prior knowledge of Snakemake needed to go through
this.

## Contents ##

There are a total of 14 examples, 2 conda environments, and one templete.

The first 10 examples, `00_example` to `09_example`, can be done on a local
machine and does not require Hive access. These examples are use to get familar
with building and using Snakemake files and workflows.

The next 3 examples, `10_example` to `12_example`, are meant to show how to best
used Snakemake on Hive. These examples walk you through how workflows are made
and ran on Hive and how resources are managed on a shared space.

The last example, `13_example`, are a collection of increasingly more
complicated example Snakemake workflows that are meant to showcase different
functions of Snakemake and its interactions with Hive.

The conda environments are used for different purposes. `basic.yaml` has
Snakemake, which allows Snakemake to be used locally. `snakehive.yaml` has
Snakemake as well and it also has other dependencies that allow Snakemake to be
used in a slurm script. This environment is intended to be used in Hive.

The templete is meant to be a templete workflow that is used to quickly start a
Snakemake environment.