rule file:
    input:
        '1pct.fa.gz'
    output:
        'results/file.txt'
    threads: 1
    resources:
        mem_mb=200,
        runtime=2
    shell:
        'echo {input} > {output}'