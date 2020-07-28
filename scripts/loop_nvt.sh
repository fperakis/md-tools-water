#!/bin/bash
cd ../data/
for T in $(seq 300 10 300)
do 
  mkdir T=${T}
  cd T=${T}
  gmx grompp -f ../../mdp/nvt.mdp -c em.tpr -r em.tpr -p topol.top -o nvt.tpr
  sbatch ../../batch/nvt.sh
  cd ..
done


