#!/bin/bash
cd ../data/
for T in $(seq 180 10 300)
do 
  mkdir T=${T}
  cd T=${T}
  # update mdp file
  cp ../../mdp/npt.mdp npt_${T}.mdp
  sed -i "s/300/$T/g" npt_${T}.mdp
  # run gromp
  gmx grompp -f npt_${T}.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
  sbatch ../../batch/npt.sh
  cd ..
done
squeue -lu fperakis

