SAMPLES = ["A", "B"]


rule all:
    input:
        expand("plots/{type}_quals.png", type = ['snps', 'indels'])

rule bwa_map:
    input:
        "data/genome.fa",
        "data/samples/{sample}.fastq"
    output:
        "mapped_reads/{sample}.bam"
    conda:
        "environment.yaml"
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"


rule samtools_sort:
    input:
        "mapped_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam"
    conda:
        "environment.yaml"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "
        "-O bam {input} > {output}"


rule samtools_index:
    input:
        "sorted_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam.bai"
    conda:
        "environment.yaml"
    shell:
        "samtools index {input}"


rule bcftools_call:
    input:
        fa="data/genome.fa",
        bam=expand("sorted_reads/{sample}.bam", sample=SAMPLES),
        bai=expand("sorted_reads/{sample}.bam.bai", sample=SAMPLES)
    output:
        "calls/all.vcf"
    conda:
        "environment.yaml"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

rule split_calls:
    input:
        "calls/all.vcf"
    output:
        "calls/{type}.vcf"
    conda:
        "environment.yaml"
    shell:
        "bcftools view --types {wildcards.type} results/all.vcf > {output}"

rule plot_quals:
    input:
        "calls/{type}.vcf"
    output:
        "plots/{type}_quals.png"
    conda:
        "environment.yaml"
    script:
        "scripts/plot-quals.py"