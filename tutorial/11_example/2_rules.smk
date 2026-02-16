rule all:
    input:
        'results/echo.txt',
        'results/ATG.txt'

rule echo:
    input:
        '1pct.fa.gz'
    output:
        'results/echo.txt'
    shell:
        'echo "this is the input file: {input}" > {output}'

rule search:
    input:
        'results/ATG.txt'