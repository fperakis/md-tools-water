#!/bin/bash

## LOAD GROMACS 2019
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

# copy topology file
cp ../src/topol.top .

# solvate a box
gmx solvate -cs tip4p -o conf.gro -box 2.3 2.3 2.3 -p topol.top

# prepare minimization
gmx grompp -f ../mdp/min.mdp -o em.tpr -pp min -po min

# run minimization
sbatch ../batch/em.sh

#gmx mdrun -deffnm min

# equilibration NVT
#gmx grompp -f mdp/eql.mdp -o eql -pp eql -po eql -c min -t min
#gmx mdrun -deffnm eql

# equilibration NPT
#gmx grompp -f mdp/eql2.mdp -o eql2 -pp eql2 -po eql2 -c eql -t eql
#gmx mdrun -deffnm eql2

# production
#gmx grompp -f mdp/prd.mdp -o prd -pp prd -po prd -c eql2 -t eql2
#gmx mdrun -deffnm prd
