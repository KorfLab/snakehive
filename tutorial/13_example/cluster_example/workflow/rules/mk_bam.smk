rule mk_bam:
    input:
        f'resources/{config['sam_name']}'
    output:
        f'results/{config['bam_name']}'
    conda:
        '../envs/mk_bam.yaml'
    log:
        stdout='workflow/logs/mk_bam.out',
        stderr='workflow/logs/mk_bam.err'
    threads: 1
    resources:
        mem_mb=200,
        runtime=3
    shell:
        'command time -v samtools view -bS {input} > {output} 2> {log.stderr}'