import argparse
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser()
parser.add_argument('--input', help='input')
parser.add_argument('--output', help='output')
arg = parser.parse_args()

graph = {}
with open(arg.input, 'r') as fp:
    for line in fp:
        if line.find('max') != -1:
            ylab, xlab = line.split(',')
            continue
        y, x = line.split(',')
        graph[int(x.strip())] = y

ls_size = []
ls_mem  = []
for size, mem in sorted(graph.items()):
    ls_size.append(size)
    ls_mem.append(mem)

plt.plot(ls_size, ls_mem, color='black', marker='*', markerfacecolor='gold', markersize=8)
plt.xlabel('file size')
plt.xlim(0)
plt.ylabel('memory usage')
plt.title('samtools memory usage')
plt.savefig(arg.output)