rule search:
    input:
        '1pct.fa.gz'
    output:
        'results/search.txt'
    threads: 1
    resources:
        mem_mb=200,
        runtime=2
    shell:
        'zgrep TAG {input} -c > {output}'