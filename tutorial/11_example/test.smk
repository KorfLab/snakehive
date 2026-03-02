rule mk_env:
    output:
        'results/test.txt'
    conda:
        'test.yaml'
    shell:
        'echo {conda} > {output}'