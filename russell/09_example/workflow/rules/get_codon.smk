rule codon:
    input:
        config['genome']
    output:
        'results/{codon}_abundancy.txt'
    log:
        stderr = 'workflow/logs/{codon}_codon.err'
    conda:
        '../envs/time.yaml'
    shell:
        'command time -v grep -c {wildcards.codon} {input} > {output} 2> {log.stderr}'