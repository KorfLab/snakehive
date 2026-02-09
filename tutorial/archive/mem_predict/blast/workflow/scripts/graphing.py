import argparse
import matplotlib.pyplot as plt
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--input', help='input')
parser.add_argument('--output', help='output')
arg = parser.parse_args()

table = []
with open(arg.input, 'r') as fp:
    for line in fp:
        if line.find('time') != -1:
            line = line.strip()
            column = line.split(',')
            continue
        line = line.strip(',\n')
        line = line.split(',')
        table.append(line)

s_table = sorted(table, key=lambda x: x[3])

plt.table(cellText=s_table, colLabels=column, cellLoc='center', loc='center')
plt.axis('off')
plt.tight_layout()
plt.title('blast table', y=0.75)
# plt.show()
plt.savefig(arg.output, format='pdf')