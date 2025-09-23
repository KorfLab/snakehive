rule blast:
    input:
        query = 'resources/reads.fa',
        database = 'resources/1pct_db'
    output:
        'results/{thres}-{win}-{link}.txt'
    conda:
        '../envs/blast.yaml'
    log:
        stdout = 'workflow/logs/{thres}-{win}-{link}.out',
        stderr = 'workflow/logs/{thres}-{win}-{link}.err'
    resources:
        mem_mb=225,
        time='1:00'
    shell:
        '''
        blastn \
        -query {input.query} \
        -db {input.database}/1pct \
        -out {output} \
        -dust '{wildcards.thres} {wildcards.win} {wildcards.link}' \
        > {log.stdout} 2> {log.stderr}
        '''

rule blast_unfiltered:
    input:
        query = 'resources/reads.fa',
        database = 'resources/1pct_db'
    output:
        'results/no.txt'
    conda:
        '../envs/blast.yaml'
    log:
        stdout = 'workflow/logs/no.out',
        stderr = 'workflow/logs/no.err'
    resources:
        mem_mb=200,
        time='1:00'
    shell:
        '''
        blastn \
        -query {input.query} \
        -db {input.database}/1pct \
        -out {output} \
        -dust 'no' \
        > {log.stdout} 2> {log.stderr}
        '''