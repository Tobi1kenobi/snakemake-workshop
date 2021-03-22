PROTAGONISTS = config['BOOK_INFO'].keys()
WORDS_DICT = config['BOOK_INFO']

rule all:
    input: 
        expand("plots/bar_{protagonists}.png", protagonists = PROTAGONISTS)

rule find_words:
    input: 
        book="data/{protagonist}.txt"
    output: 
        "results/{protagonist}.txt"
    params:
        search=lambda wildcards: ('\|').join(WORDS_DICT[wildcards.protagonist]) # Uses dictionary and wildcards so only book-relevant words searched
    shell:
        '''
        grep -o '{params.search}' {input.book} > results/{wildcards.protagonist}.txt
        ''' 

rule plot_words:
    input: 
        only_words="results/{protagonist}.txt"
    output: 
        barplot="plots/bar_{protagonist}.png"
    script:
        "scripts/barplot.R"