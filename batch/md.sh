#!/bin/bash

#SBATCH -A SNIC2020-5-289
# Name of the job
#SBATCH -J MD
#SBATCH -t 12:00:00
#SBATCH -n 32

# It is always best to do a ml purge before loading modules in a submit file
ml purge > /dev/null 2>&1

# Load the module for GROMACS and its prerequisites.
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

# Automatic selection of single or multi node based GROMACS
if [ $SLURM_JOB_NUM_NODES -gt 1 ]; then
    GMX="gmx_mpi"
    MPIRUN="mpirun"
    ntmpi=""
else
    GMX="gmx"
    MPIRUN=""
    ntmpi="-ntmpi $SLURM_NTASKS"
fi

# Automatic selection of ntomp argument based on "-c" argument to sbatch
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
else
    ntomp="1"
fi
# Make sure to set OMP_NUM_THREADS equal to the value used for ntomp
# to avoid complaints from GROMACS
export OMP_NUM_THREADS=$ntomp

$MPIRUN $GMX mdrun $ntmpi -ntomp $ntomp -deffnm md
