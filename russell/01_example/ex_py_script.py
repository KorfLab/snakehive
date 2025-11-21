with open(snakemake.output[0], 'w') as out:
    out.write(f'this is the input: {snakemake.input}\n')
    out.write(f'this is the output: {snakemake.output}')