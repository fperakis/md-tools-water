# md-tools-water

This is a collection of tools for running water MD simulations using GROMACS on HPC2N (Kebnekaise)
based on the tutorial
$ https://www.svedruziclab.com/tutorials/gromacs/1-tip4pew-water/


### LOAD GROMACS 2019

```bash 
$ ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4

$ ml GROMACS/2019.4-PLUMED-2.5.4

$ cd scripts
```

### EQUILIBRATION (uses pipeline.sh)
```bash 
$ bash loop_em.sh
```

### NVT
```bash 
$ bash loop_nvt.sh

$ bash ../analysis/nvt_analysis.sh
```

### NPT
```bash 
$ bash loop_npt.sh

$ bash ../analysis/npt_analysis.sh
```

### MD
```bash 
$ bash loop_md.sh

$ bash ../analysis/md_analysis.sh
```

