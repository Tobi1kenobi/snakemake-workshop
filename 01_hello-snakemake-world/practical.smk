outfiles = ['1_I', '2_ran', '3_my', '4_first', '5_snakemake', '6_pipeline']

rule all:
    input:
        expand("results/{filename}",filename=outfiles)

