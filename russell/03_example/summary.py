import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('--start', type=int)
parser.add_argument('--end', type=int)
arg = parser.parse_args()

for i in range(arg.start, arg.end+1):
    os.system(f'sacct --format=jobid,state,maxrss,memeq,elapsed -j {i}')