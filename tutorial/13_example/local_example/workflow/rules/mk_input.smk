rule mk_input:
    output:
        'resources/00_input.sam'
    conda:
        '../envs/mk_input.yml'
    log:
        stdout='workflow/logs/mk_input.out',
        stderr='workflow/logs/mk_input.err'
    shell:
        'command time -v python3 workflow/scripts/mk_input.py {log.stdout} {log.stderr} {output} 2>> {log.stderr}'