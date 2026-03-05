rule conda:
    output:
        'results/conda.txt'
    threads: 1
    resources:
        mem_mb=250,
        runtime=2
    conda:
        'time.yaml'
    shell:
        'command time -v echo "{output}" > {output}'