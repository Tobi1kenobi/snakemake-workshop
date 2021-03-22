PROTAGONISTS = config['BOOK_INFO'].keys()
WORDS_DICT = config['BOOK_INFO']

WORDS = ['hook', 'fly', 'London']


rule all:
    input: 
        expand("plots/bar_{protagonists}.png", protagonists = PROTAGONISTS)

rule find_words:
    input: 
        book="data/{protagonist}.txt"
    output: 
        "results/{protagonist}_{word}.txt"
    shell:
        '''
        grep -o {wildcards.word} {input.book} > results/{wildcards.protagonist}_{wildcards.word}.txt
        ''' 

# rule merge_files:
#     input: 
#         lambda wildcards: expand("results/{{protagonist}}_{word}.txt", word=WORDS_DICT[wildcards.protagonist])
#     output:
#         only_words="results/{protagonist}.txt"
#     shell:
#         '''
#         cat {input} > {output}
#         '''

rule merge_files:
    input: 
        expand("results/{{protagonist}}_{word}.txt", word=WORDS)
    output:
        only_words="results/{protagonist}.txt"
    shell:
        '''
        cat {input} > {output}
        '''

rule plot_words:
    input: 
        only_words="results/{protagonist}.txt"
    output: 
        barplot="plots/bar_{protagonist}.png"
    script:
        "scripts/barplot.R"