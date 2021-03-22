# Snakemake introduction and simple pipelines

![Workshop intro slide](Images/Workshop-intro.png)

## What this will cover

* Installation and writing simple snakemake rules and pipelines
* The snakemake tutorial from the snakemake website
* Utilising conda environments for rules
* Submitting jobs with snakemake

## What this won't cover

* Cloud (AWS/Google cloud) execution
* Singularity/Docker containers
* Checkpoints
* Unit testing
* Pros/Cons of Snakemake versus Nextflow, Cromwell, Luigi, etc
* Any other advanced snakemake trickery


## Installation

Official reccomendation is to install with mamba (faster version of conda) but I had no issues doing this:
```
conda create -n snake-env snakemake -c conda-forge -c bioconda
conda activate snake-env
```

# Snakemake workshop

## Example 01 - Hello (Snakemake) world!

Executing a very simple Snakefile and then breaking down how the same end result can be approached in three different ways as well as the main flags/options do.

### Snakefile

Very simple one-rule snakemake pipeline, clearly illustrating the basic language and syntax.

```bash
cd 01_hello-snakemake-world
snakemake -npr
snakemake
```

What does `-n` do? Dry run.

What does `-p` do? Print commands to be executed.

What does `-r` do? Prints the REASON each rule needs to be run.

Running `snakemake -j 1` will execute the pipeline in `Snakefile` by running all the rules that lead to the input for `rule all` being generated. 


![Rule DAG](Images/01_rule-dag.png)

![File graph](Images/01_filegraph.png)

### Wilcards.smk

The same output as above but written in a more "snakemakey" way introducing wildcards and the expand function.

```bash
rm -r results
snakemake -s wildcards.smk -npr
snakemake -s wildcards.smk
```

![Wildcards DAG](Images/01_wildcards-dag.png)

### Loop.smk

This snakefile introduces the pythonic aspect to Snakemake. Normal python code works in a snakefile and this can be used to simplify and extend snakemake's main functionality.

```bash
rm -r results
snakemake -s loop.smk -npr
snakemake -s loop.smk
```

### Practical.smk

The task here is to complete `practical.smk` to produce the same output as the three other snakefiles but without using wildcards or loops (i.e. only expand).

```bash
rm -r results
```

## Example 02 - Plot some words

Stepping things up a notch, passing input and output between multiple rules and integrating R scripts into Snakemake.

### Practical.smk

Here I have broken down the single rule from the previous snakefiles into two for parallelisation purporses. Of course this probably isn't necessary for a simple grep but for other bioinformatics uses this can be very helpful so is a good example.
You must complete `practical.smk` by adding a new rule. It involves combining expand and wildcards.

```bash
rm -r results
rm -r plots
```

## Example 03 - Snakemake tutorial

The official Snakemake tutorial taken from their documentation. It is a very simple read mapping and variant calling pipeline. I've sprinkled in a few extras here that aren't part of the tutorial to hopefully pad it out a little bit more.
