#!/bin/bash

#SBATCH -A SNIC2020-9-36
#SBATCH -t 20:00:00
#SBATCH -n 1

# It is always best to do a ml purge before loading modules in a submit file
ml purge > /dev/null 2>&1

# Load the module for GROMACS and its prerequisites.
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4


# parameters and constants
pi=$(echo "scale=8; 4*a(1)" | bc -l)
N=100 # number of points in the golden spiral
t=10000 # time point (ps)

# make index file with non-dummy atoms
gmx select -s md_300.gro -f md_300.xtc -on md_noMW_300.ndx -xvg none -select "all and not name MW"

# dump a single frame
gmx trjconv -f md_300.xtc -s md_300.tpr -dump ${t} -o saxs/md_300_${t}.pdb -n md_noMW_300.ndx -pbc atom -center << EOF
0
EOF

# remove hydrogens
grep -v '        H' saxs/md_300_${t}.pdb > saxs/md_300_${t}_noH.pdb 

# spherical averaging loop (spiral)
for j in $(seq 0 1 ${N})
do

# define pi
phi=$(echo "scale=8; (1 + sqrt(5))*$j*180" | bc)

# define theta
d=$(echo "scale=8; 1-2*$j/$N" | bc)
export d
acos=`perl -E 'use Math::Trig; say acos($ENV{d})'`
theta=$(echo "scale=8; $acos*180/$pi"| bc )

# rotate structure (first along theta, then along phi)
gmx editconf -f saxs/md_300_${t}_noH.pdb -o saxs/md_300_${j}_${t}.gro -rotate ${theta} 0 0 -center 0 0 0
gmx editconf -f saxs/md_300_${j}_${t}.gro -o saxs/md_300_${j}_${t}.pdb -rotate 0 ${phi} 0 -center 0 0 0

# calculate total saxs
gmx saxs -f saxs/md_300_${j}_${t}.pdb -s saxs/md_300_${j}_${t}.pdb -sq saxs/saxs_300_${j}_${t}.xvg -energy 8.041 << EOF
0
EOF

# clean up
rm saxs/md_300_${j}_${t}.pdb
rm saxs/md_300_${j}_${t}.gro

done
rm saxs/md_300_${t}_noH.pdb
rm saxs/md_300_${t}.pdb 

