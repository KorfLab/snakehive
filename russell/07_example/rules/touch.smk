rule touch:
    output:
        'results/{ex_num}_touch.txt'
    shell:
        'touch {output}'