#!/bin/bash
cd ..
mkdir data
cd data
for T in $(seq 180 10 300)i
do 
  mkdir T=${T}
  cd T=${T}
  sh ../../scripts/pipeline.sh
  cd ..
done
