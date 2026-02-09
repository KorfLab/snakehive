rule create:
    input:
        'resources/1pct.fa'
    output:
        'resources/1pct_reads.fa'
    log:
        out='workflow/logs/mk_in.out',
        err='workflow/logs/mk_in.err'
    conda:
        '../envs/mk_in.yaml'
    params:
        nreads = config['reads']['number'],
        lenread = config['reads']['length']
    shell:
        '''
        python3 workflow/scripts/get_read.py \
        --nreads {params.nreads} \
        --lenread {params.lenread} \
        --genome {input} \
        --out {output} \
        --stdout {log.out} \
        --stderr {log.err} \
        2>> {log.err}
        '''

rule mk_db:
    input:
        'resources/1pct.fa'
    output:
        directory('resources/1pct_db')
    conda:
        '../envs/mk_in.yaml'
    log:
        stdout = 'workflow/logs/mk_db.out',
        stderr = 'workflow/logs/mk_db.err'
    params:
        dbtype = 'nucl',
        in_type = 'fasta'
    shell:
        '''
        makeblastdb \
        -in {input} \
        -out {output}/1pct \
        -dbtype {params.dbtype} \
        -input_type {params.in_type} \
        > {log.stdout} 2> {log.stderr}
        '''

rule blast:
    input:
        query = 'resources/1pct_reads.fa',
        database = 'resources/1pct_db'
    output:
        'resources/ws{wsize}_c{cores}.txt'
    conda:
        '../envs/mk_in.yaml'
    log:
        stdout = 'workflow/logs/ws{wsize}_c{cores}.out',
        stderr = 'workflow/logs/ws{wsize}_c{cores}.err'
    threads:
        lambda wc: int(wc.cores)
    shell:
        '''
        command time -v blastn \
        -query {input.query} \
        -db {input.database}/1pct \
        -out {output} \
        -num_threads {threads} \
        -word_size {wildcards.wsize} \
        > {log.stdout} 2> {log.stderr}
        echo "threads={wildcards.cores}" >> {log.stderr}
        echo "ws={wildcards.wsize}" >> {log.stderr}
        '''