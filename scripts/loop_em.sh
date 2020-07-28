#!/bin/bash
cd ..
mkdir data
cd data
for T in $(seq 300 10 300)
do 
  mkdir T=${T}
  cd T=${T}
  sh ../../scripts/pipeline.sh
  cd ..
done
