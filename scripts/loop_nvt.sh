#!/bin/bash
cd ../data/
for T in $(seq 180 10 300)
do 
  cd T=${T}
  gmx grompp -f ../../mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
  sbatch ../../batch/nvt.sh
  cd ..
done


