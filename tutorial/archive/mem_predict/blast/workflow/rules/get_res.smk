rule filter:
	input:
		'resources/ws{wsize}_c{cores}.txt'
	output:
		'resources/tmp/preprocess_s{wsize}c{cores}.txt'
	log:
		out = 'workflow/logs/filtered_s{wsize}c{cores}.out',
		err = 'workflow/logs/filtered_s{wsize}c{cores}.err'
	conda:
		'../envs/mk_in.yaml'
	shell:
		"grep -e 'Maximum' -e 'threads' -e 'ws' -e 'Elapsed' workflow/logs/ws{wildcards.wsize}_c{wildcards.cores}.err > {output} 2> {log.err}"

rule processed:
	input:
		'resources/tmp/preprocess_s{wsize}c{cores}.txt'
	output:
		'resources/filtered/filtered_s{wsize}c{cores}.csv'
	log:
		out = 'workflow/logs/processed_s{wsize}c{cores}.out',
		err = 'workflow/logs/processed_s{wsize}c{cores}.err'
	conda:
		'../envs/mk_in.yaml'
	shell:
		'python3 workflow/scripts/filtered.py --input {input} --output {output}'

rule combine:
	input:
		expand('resources/filtered/filtered_s{wsize}c{cores}.csv', wsize=config['ws'], cores=config['threads'])
	output:
		'resources/combined.csv'
	conda:
		'../envs/mk_in.yaml'
	log:
		out = 'workflow/logs/combined.out',
		err = 'workflow/logs/combined.err'
	shell:
		'python3 workflow/scripts/combine.py --input "{input}" --output {output}'