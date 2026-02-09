import argparse
import re

parser = argparse.ArgumentParser()
parser.add_argument('--input', help='input')
parser.add_argument('--output', help='output')
arg = parser.parse_args()

with open(arg.input, 'r') as fp, open(arg.output, 'w') as out:
    for line in fp:
        line = line.strip()
        if line.find('Command') != -1: continue
        if line.find('Maximum') != -1:
            line = line[line.find('kbytes')+9:]
            out.write(f'{line},')
            continue
        line = line.split()
        out.write(line[4])