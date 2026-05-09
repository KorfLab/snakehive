import argparse
import os
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--input', type=str, help='input directory')
parser.add_argument('--output', type=str, help='output file')
arg = parser.parse_args()
indir = arg.input

used =[]
files = sorted(os.listdir(indir))
with open(arg.output, 'w') as out: out.write('')
for n in range(len(files)):
    for m in range(len(files)):
        if f'{files[n]}-{files[m]}' in used or f'{files[m]}-{files[n]}' in used: continue
        with open(arg.output, 'a') as out:
            out.write(f'{files[n]} -- {files[m]}\n')
        os.system(f'diff {indir}/{files[n]} {indir}/{files[m]} | grep -v -e "^<" -e "^>" -e "^-" | wc -l >> {arg.output}')
        used.append(f'{files[n]}-{files[m]}')