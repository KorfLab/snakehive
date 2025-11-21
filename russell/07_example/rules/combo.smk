rule touch:
    output:
        'results/{ex_num}_touch.txt'
    shell:
        'touch {output}'

rule echo:
    output:
        'results/{ex_num}_echo.txt'
    shell:
        'echo "this is from within combo.smk" > {output}'