#!/bin/bash

## LOAD GROMACS 2019
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

# copy topology file
cp ../../src/topol.top .

# solvate a box
gmx solvate -cs tip4p -o box.gro -box 9 9 9 -p topol.top

# prepare minimization
gmx grompp -f ../../mdp/min.mdp -c box.gro -o em.tpr -p topol.top

# run minimization
sbatch ../../batch/em.sh
