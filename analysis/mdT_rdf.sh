#!/bin/bash
cd ../data/

# loop over temperatures
for T in $(seq 180 10 300)
do 

cd T=${T}
mkdir rdf

# update submission script
cp ../../batch/rdf.sh rdf/rdf_${T}.sh
sed -i "s/300/$T/g" rdf/rdf_${T}.sh

# submit jobs
sbatch rdf/rdf_${T}.sh

cd ..
done # temperature loop

# check queue
squeue -lu fperakis  


