import argparse
import os
# import subprocess
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--input', type=str, help='input directory')
parser.add_argument('--output', type=str, help='output file')
arg = parser.parse_args()
indir = arg.input
# indir = arg.input.split('/')
# indir = '/'.join(indir[:-1])

# counter = 0
used =[]
starts = ['<','>','-']
files = sorted(os.listdir(indir))
with open(arg.output, 'w') as out: out.write('')
for n in range(len(files)):
    for m in range(len(files)):
        if f'{files[n]}-{files[m]}' in used or f'{files[m]}-{files[n]}' in used: continue
    #     filtered = ''
    #     diff = subprocess.run(['diff', f'{indir}/{files[n]}', f'{indir}/{files[m]}'], stdout=subprocess.PIPE, text=True)
    #     diff = diff.stdout.split('\n')
    #     if diff != ['']:
    #         for i in range(len(diff)-1):
    #             if diff[i][0] in starts: continue
    #             else: filtered += f'{diff[i]}\n'
        with open(arg.output, 'a') as out:
            out.write(f'{files[n]} -- {files[m]}\n')
            # out.write(f'{filtered.count('\n')}\n')
        os.system(f'diff {indir}/{files[n]} {indir}/{files[m]} | grep -v -e "^<" -e "^>" -e "^-" | wc -l >> {arg.output}')
        used.append(f'{files[n]}-{files[m]}')
        # print(used)
        # counter += 1
        # if counter >= 3: sys.exit()