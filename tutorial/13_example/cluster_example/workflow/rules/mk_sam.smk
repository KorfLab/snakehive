rule mk_sam:
    output:
        f'resources/{config['sam_name']}'
    conda:
        '../envs/mk_sam.yaml'
    log:
        stdout='workflow/logs/mk_sam.out',
        stderr='workflow/logs/mk_sam.err'
    threads: 1
    resources:
        mem_mb=300,
        runtime=3
    shell:
        '''
        command time -v \
        python3 workflow/scripts/mk_sam.py {log.stdout} {log.stderr} {output} \
        2>> {log.stderr}
        '''