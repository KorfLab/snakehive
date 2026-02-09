
rule mk_output:
    input:
        'resources/00_input.sam'
    output:
        'results/00_output.bam'
    conda:
        '../envs/mk_output.yml'
    log:
        stdout='workflow/logs/mk_output.out',
        stderr='workflow/logs/mk_output.err'
    shell:
        'command time -v samtools view -bS {input} > {output} 2> {log.stderr}'