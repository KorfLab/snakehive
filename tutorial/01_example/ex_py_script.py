with open(snakemake.output[0], 'w') as out:
    out.write(f'This is the input: {snakemake.input}\n')
    out.write(f'This is the output: {snakemake.output}')