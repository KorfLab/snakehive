import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--input', help='input')
parser.add_argument('--output', help='output')
arg = parser.parse_args()

with open(arg.input, 'r') as fp, open(arg.output, 'w') as out:
    for line in fp:
        line = line.strip()
        if line.find('Command') != -1: continue
        elif line.find('Maximum') != -1:
            line = line[line.find('kbytes')+9:]
            out.write(f'{line},')
        elif line.find('Elapsed') != -1:
            line = line.split()
            out.write(f'{line[7]},')
        elif line.find('threads') == 0:
            out.write(f'{line[8:]},')
        elif line.find('ws') ==0:
            out.write(f'{line[3:]},')