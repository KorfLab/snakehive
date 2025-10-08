rule blast:
    input:
        query = 'resources/trial{num}_reads.fa',
        database = 'resources/1pct_db'
    output:
        'results/blast_out{num}.txt'
    conda:
        '../envs/blast.yaml'
    log:
        stdout = 'workflow/logs/blast.out{num}',
        stderr = 'workflow/logs/blast.err{num}'
    threads: 2
    resources:
        mem_mb=250
    shell:
        '''
        command time -v blastn \
        -query {input.query} \
        -db {input.database}/1pct \
        -out {output} \
        -num_threads {threads} \
        > {log.stdout} 2> {log.stderr}
        '''