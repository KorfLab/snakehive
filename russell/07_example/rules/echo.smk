rule echo:
    output:
        'results/{ex_num}_echo.txt'
    shell:
        'echo "this is from within echo.smk" > {output}'