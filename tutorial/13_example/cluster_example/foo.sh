for file in jobs/rule*/*; do
    jobid=${file#*/}
    jobid=${jobid#*/}
    jobid=${jobid%.*}
    echo $jobid
done