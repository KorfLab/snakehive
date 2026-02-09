import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--output', help='output')
parser.add_argument('--line_num', help='number of lines', type=int)
arg = parser.parse_args()

with open(arg.output, 'w') as out:
    out.write('@HD\tVN:1.6\tSO:unsorted\n')
    out.write('@SQ\tSN:chr1\tLN:2048\n')
    for i in range(arg.line_num):
        out.write(f'read{i+1}\t0\tchr1\t1\t255\t8M\t*\t0\t0\tACTGACTG\t*\n')