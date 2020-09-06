#!/bin/bash

#SBATCH -A SNIC2020-9-36
#SBATCH -t 20:00:00
#SBATCH -n 1

# It is always best to do a ml purge before loading modules in a submit file
ml purge > /dev/null 2>&1

# Load the module for GROMACS and its prerequisites.
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

for t in $(seq 100 100 10000)
do

# dump a single frame (without dummy atoms)
gmx trjconv -f md_300.xtc -s md_300.tpr -dump ${t} -o rdf/md_300_${t}.pdb -n md_noMW_300.ndx -pbc atom -center << EOF
0
EOF

# remove hydrogens
grep -v '        H' rdf/md_300_${t}.pdb > rdf/md_300_${t}_noH.pdb 

# calculate rdf
gmx rdf -f rdf/md_300_${t}_noH.pdb  -s rdf/md_300_${t}_noH.pdb -o rdf/rdf_300_${t}.xvg -dt ${t} -sel "name OW" -ref "name OW"

# clean up
rm rdf/md_300_${t}.pdb
rm rdf/md_300_${t}_noH.pdb

done
