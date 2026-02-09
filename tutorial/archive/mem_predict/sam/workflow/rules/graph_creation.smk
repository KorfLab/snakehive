rule graph:
    input:
        'resources/combined.csv'
    output:
        'results/samtools_usage.pdf'
    conda:
        '../envs/graph.yaml'
    log:
        out = 'workflow/logs/graph.out',
        err = 'workflow/logs/graph.err'
    shell:
        'python3 workflow/scripts/graphing.py --input {input} --output {output} > {log.out} 2> {log.err}'