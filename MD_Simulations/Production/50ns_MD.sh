#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=6-00:00:00
#SBATCH --mem=10GB
#SBATCH --account=xxx
#
#
#
for case in xxx ;
##
##
do
echo $case
for number in 1 2 3 4 5;
do
#
$AMBERHOME/bin/pmemd.cuda -O -i eq_norst.in -o ${case}_${number}_eq.out -p $case.prmtop -c ${case}_${number}_heat2.rst -ref ${case}_${number}_heat2.rst -r ${case}_${number}_eq.rst
#
$AMBERHOME/bin/pmemd.cuda -O -i MD_50ns.in -o ${case}_${number}_50nsMD.out -p $case.prmtop -c ${case}_${number}_eq.rst -ref ${case}_${number}_eq.rst -r ${case}_${number}_MD.rst -x ${case}_${number}_MD.nc

done
done
