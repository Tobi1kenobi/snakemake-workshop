# Normal python code works in snakemake as expected
sentence = "I ran my first snakemake pipeline"
words = sentence.split(' ')

# Here I use list comprehension to generate a python list which is seen by
# snakemake as identical to the list in Snakefile
rule all:
    input:
        ['results/{}_{}'.format(i, words[i-1]) for i in range(1,7)]

# Here I use a loop to emulate what wildcards do in wildcards.smk, this is 
# atypical but can be useful in some niche examples where wildcards are not
# sufficient
for i in range(1,7):
    rule:
        output: 
            "results/{}_{}".format(i, words[i-1])
        shell: 
            '''
            touch {output}
            '''