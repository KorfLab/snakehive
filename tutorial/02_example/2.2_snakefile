rule conda:
    output:
        'results/conda.txt'
    conda:
        'time.yaml'
    shell:
        'command time -v echo "{output}" > {output}'