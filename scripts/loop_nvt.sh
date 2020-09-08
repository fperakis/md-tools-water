#!/bin/bash
cd ../data/
for T in $(seq 180 10 300)
do 
  cd T=${T}
  # update mdp file
  cp ../../mdp/nvt.mdp nvt_${T}.mdp
  sed -i "s/300/$T/g" nvt_${T}.mdp
  # run gromp
  gmx grompp -f nvt_${T}.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
  sbatch ../../batch/nvt.sh
  cd ..
done


