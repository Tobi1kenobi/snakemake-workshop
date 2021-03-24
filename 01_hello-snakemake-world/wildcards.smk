# Expand will generate list just like that seen in Snakefile
# Curly braces within expand works similar to the format function in python
rule all:
    input:
        expand("results/{filename}",filename=['1_I', '2_ran', '3_my', '4_first', '5_snakemake', '6_pipeline'])

# Wildcards work differently to expand/lists - they cause a rule to be
# executed multiple times, one for each match
# Curly braces in a string = wildcard
rule create_files:
    output: 
        "results/{file}"
    shell: 
        '''
        touch {output}
        '''


















# Wildcards save your from typing this and allow you to parallelise your jobs
# rule create_files:
#     output: 
#         "results/1_I",
#         "results/2_ran",
#         "results/3_my",
#         "results/4_first",
#         "results/5_snakemake",
#         "results/6_pipeline"
#     shell: 
#         '''
#         touch {output[0]}
#         touch {output[1]}
#         touch {output[2]}
#         touch {output[3]}
#         touch {output[4]}
#         touch {output[5]}
#         '''