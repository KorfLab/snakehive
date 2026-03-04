rule hello:
    output:
        'results/10.2_hello.txt'
    shell:
        'echo "hello world" > {output}'