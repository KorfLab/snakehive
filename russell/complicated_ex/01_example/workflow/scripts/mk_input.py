import sys

# stdout = sys.argv[1]
# stderr = sys.argv[2]
# out    = sys.argv[3]

with open(sys.argv[1], 'w') as out, open(sys.argv[2], 'w') as err:
    sys.stdout = out
    sys.stderr = err

    print('error message', file=sys.stderr)

    print('start of script')

    with open(sys.argv[3], 'w') as out:
        out.write('@HD\tVN:1.6\tSO:unsorted\n')
        out.write('@SQ\tSN:chr1\tLN:2048\n')
        out.write('read1\t0\tchr1\t1\t255\t8M\t*\t0\t0\tACTGACTG\t*')

    print('end of script', flush=True)