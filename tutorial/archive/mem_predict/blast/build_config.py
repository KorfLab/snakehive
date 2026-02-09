import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-n', type=int, help='number of files')
arg = parser.parse_args()

with open('config/config.yaml', 'w') as out:
    out.write('num_lines:\n')
    for i in range(arg.n):
        out.write(f'- {2**i}\n')