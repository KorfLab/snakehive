import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('--input', help='input')
parser.add_argument('--output', help='output')
arg = parser.parse_args()

indir = arg.input
indir = indir.split('/')
indir = indir[0:-1]
indir = f'{indir[0]}/{indir[1]}'

with open(arg.output, 'w') as out:
    out.write('time,mem,threads,word_size\n')

for file in os.listdir(indir):
    with open(f'{indir}/{file}', 'r') as fp, open(arg.output, 'a') as out:
        for line in fp:
            out.write(f'{line}\n')