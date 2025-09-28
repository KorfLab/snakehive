rule move:
    input:
        expand('results/{thres}-{win}-{link}.txt',
			thres=config['thresholds'],
			win=config['windows'],
			link=config['linkers']),
        'results/no.txt'
    output:
        directory('results/blast')
    log:
        stdout = 'workflow/logs/move.out',
        stderr = 'workflow/logs/move.err'
    conda:
        '../envs/simple.yaml'
    resources:
        mem_mb=150
    shell:
        '''
        mkdir -p {output} 2> {log.stderr}
        mv {input} {output} 2>> {log.stderr}
        '''

rule compare:
    input:
        'results/blast'
    output:
        'results/compared.txt'
    log:
        stdout = 'workflow/logs/compared.out',
        stderr = 'workflow/logs/compared.err'
    conda:
        '../envs/simple.yaml'
    resources:
        mem_mb=200
    shell:
        '''
        rm {input}/.snakemake_timestamp 2>> {log.stderr}
        command time -v python3 workflow/scripts/compare.py --input {input} --output {output} 2> {log.stderr}
        '''