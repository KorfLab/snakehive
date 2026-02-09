import os

os.system('rm -r resources/* results/* workflow/logs/* jobs/*')
os.system('ln -s ../../../../../datacore2024/genome_celegans/1pct.fa resources/1pct.fa')