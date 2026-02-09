import argparse
import random
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--nreads', type=int, help='number of reads')
parser.add_argument('--lenread', type=int, help='length of each read')
parser.add_argument('--genome', type=str)
parser.add_argument('--out', type=str)
parser.add_argument('--stdout', type=str)
parser.add_argument('--stderr', type=str)
arg = parser.parse_args()

with open(arg.stdout, 'w') as out, open(arg.stderr, 'w') as err:
    sys.stdout = out
    sys.stderr = err
    print('This is stdout\n')
    print('This is stderr\n', file=err)

    with open(arg.out, 'w') as output, open(arg.genome, 'r') as fp:
        genome = ''
        for line in fp:
            if '>' in line: continue
            genome += line.strip()
        starts = random.sample(range(len(genome)-arg.lenread), arg.nreads)
        for n in range(len(starts)):
            read = genome[starts[n]:starts[n]+arg.lenread]
            output.write(f'>read{n+1} {starts[n]}-{starts[n]+arg.lenread}\n')
            output.write(f'{read}\n')