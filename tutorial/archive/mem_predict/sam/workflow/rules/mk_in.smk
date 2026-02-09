rule create:
    output:
        temp('resources/samin/rng_{lines}.sam')
    log:
        out='workflow/logs/mk_in_{lines}.out',
        err='workflow/logs/mk_in_{lines}.err'
    conda:
        '../envs/mk_in.yaml'
    shell:
        'python3 workflow/scripts/mk_sam.py --output {output} --line_num {wildcards.lines} > {log.out} 2> {log.err}'

rule time:
	input:
		'resources/samin/rng_{lines}.sam'
	output:
		temp('resources/bamout/{lines}_timed.bam')
	log:
		err = 'workflow/logs/{lines}_timed.err'
	conda:
		'../envs/time.yaml'
	shell:
		'''
		command time -v samtools view -bS {input} > {output} 2> {log.err}
		ls -l {input} >> {log.err}
		'''