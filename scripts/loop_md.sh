#!/bin/bash
cd ../data/
for T in $(seq 300 10 300)
do 
  mkdir T=${T}
  cd T=${T}
  gmx grompp -f ../../mdp/md.mdp -c npt.gro -r npt.gro -p topol.top -o md.tpr
  sbatch ../../batch/md.sh
  cd ..
done
squeue -lu fperakis

