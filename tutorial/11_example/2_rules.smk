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
        mem=500M
    shell:
        'echo "this is the input file: {input}" > {output}'

rule search:
    input:
        '1pct.fa.gz'
    output:
        'results/ATG.txt'
    threads: 1
    resources:
        mem=500M
    shell:
        'zgrep ATG {input} > {output}'