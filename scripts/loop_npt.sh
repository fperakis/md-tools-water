#!/bin/bash
cd ../data/
for T in $(seq 180 10 300)
do 
  mkdir T=${T}
  cd T=${T}
  gmx grompp -f ../../mdp/npt.mdp -c nvt.tpr -r nvt.tpr -p topol.top -o npt.tpr
  sbatch ../../batch/npt.sh
  cd ..
done
squeue -lu fperakis

