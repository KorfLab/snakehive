rule all:
    input:
        'results/echo.txt',
        'results/ATG.txt'

rule echo:
    input:
        '1pct.fa.gz'
    output:
        'results/echo.txt'
    threads: 1
    resources:
        mem_mb=175,
        runtime=2
    shell:
        'echo "this is the input file: {input}" > {output}'

rule search:
    input:
        '1pct.fa.gz'
    output:
        'results/ATG.txt'
    threads: 1
    resources:
        mem_mb=200,
        runtime=2
    shell:
        'zgrep ATG {input} -c > {output}'