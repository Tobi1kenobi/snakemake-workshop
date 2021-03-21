sentence = "I ran my first snakemake pipeline"
words = sentence.split(' ')

rule all:
    input:
        expand("results/{filename}",filename=['{}_{}'.format(i, words[i-1]) for i in range(1,7)])

for i in range(1,7):
    rule:
        output: 
            "results/{}_{}".format(i, words[i-1])
        shell: 
            '''
            touch {output}
            '''