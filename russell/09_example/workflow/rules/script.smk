rule script:
    input:
        config['genome']
    output:
        'results/script.txt'
    script:
        '../scripts/ex_py_script.py'