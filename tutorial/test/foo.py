import gzip

with gzip.open('1pct.fa.gz', 'rt') as fp:
    for line in fp:
        print(line)