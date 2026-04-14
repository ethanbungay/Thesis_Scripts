#!/bin/bash
#SBATCH --account=chem023222
#SBATCH --partition=compute
#SBATCH --cpus-per-task=14
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=10:10:00
#SBATCH --mem=10GB
#
#
#
for i in *_MD.nc_cpptraj_sasa.in ;
do
echo $i
cpptraj $i
done
