# I use a dictionary as defined in the config
PROTAGONISTS = config['BOOK_INFO'].keys()
WORDS_DICT = config['BOOK_INFO']

rule all:
    input: 
        expand("plots/bar_{protagonists}.png", protagonists = PROTAGONISTS)

# The dictionary allows me to only search for terms relevant to my book
rule find_words:
    input: 
        book="data/{protagonist}.txt"
    output: 
        "results/{protagonist}.txt"
    params:
        search=lambda wildcards: ('\|').join(WORDS_DICT[wildcards.protagonist]) # Uses dictionary and wildcards so only book-relevant words searched
        # search="('\|').join(WORDS_DICT[{protagonist}])" # Alternative way of doing the above, python code will still evaluate
    shell:
        '''
        grep -o '{params.search}' {input.book} > results/{wildcards.protagonist}.txt
        '''

# Using 'script:' passes a snakemake object to barplot.R that allows access to wildcards, input, output, parameters
# Alternatively you can use 'shell:' and command line flags/options with optparse
rule plot_words:
    input: 
        only_words="results/{protagonist}.txt"
    output: 
        barplot="plots/bar_{protagonist}.png"
    script:
        "scripts/barplot.R"