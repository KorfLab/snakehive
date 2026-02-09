rule filter:
	input:
		'resources/bamout/{lines}_timed.bam'
	output:
		temp('resources/tmp/preprocess_{lines}.txt')
	log:
		out = 'workflow/logs/filtered_{lines}.out',
		err = 'workflow/logs/filtered_{lines}.err'
	conda:
		'../envs/mk_in.yaml'
	shell:
		"grep -e 'Maximum' -e 'resources' workflow/logs/{wildcards.lines}_timed.err > {output} 2> {log.err}"

rule processed:
	input:
		'resources/tmp/preprocess_{lines}.txt'
	output:
		temp('resources/filtered/{lines}_filtered.csv')
	log:
		out = 'workflow/logs/processed_{lines}.out',
		err = 'workflow/logs/processed_{lines}.err'
	conda:
		'../envs/mk_in.yaml'
	shell:
		'python3 workflow/scripts/filtered.py --input {input} --output {output}'

rule combine:
	input:
		expand('resources/filtered/{lines}_filtered.csv', lines=config['num_lines'])
	output:
		'resources/combined.csv'
	conda:
		'../envs/mk_in.yaml'
	log:
		out = 'workflow/logs/combined.out',
		err = 'workflow/logs/combined.err'
	shell:
		'python3 workflow/scripts/combine.py --input "{input}" --output {output}'