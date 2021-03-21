rule all:
    input:
        expand("results/{filename}",filename=['1_I', '2_ran', '3_my', '4_first', '5_snakemake', '6_pipeline'])

rule create_files:
    output: 
        "results/{file}"
    shell: 
        '''
        touch {output}
        '''