rule count:
    output:
        'results/{ex_num}_counts.txt'
    params:
        config['counts']
    shell:
        'echo "The counts are {params}" > {output}'