PROTAGONISTS = config['BOOK_INFO'].keys()
WORDS_DICT = config['BOOK_INFO']

# WORDS = ['hook', 'fly', 'London']


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

# Hint: Combine wildcards and expand in the input 
# Hint: When using a wildcard within expand double curly braces are necessary to escape e.g. {{wildcard}}
# Hint: If using the dictionary is a bit tricky here, I've added a commented out a variable WORDS that can be used instead
rule merge_files:


rule plot_words:
    input: 
        only_words="results/{protagonist}.txt"
    output: 
        barplot="plots/bar_{protagonist}.png"
    script:
        "scripts/barplot.R"