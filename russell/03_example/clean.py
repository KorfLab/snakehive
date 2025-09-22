import os

os.system('rm -r resources/*')
os.system('rm -r results/*')
os.system('rm -r workflow/logs/*')
os.system('rm -r jobs/*')
os.system('ln -s ../../../../datacore2024/genome_celegans/1pct.fa resources/')