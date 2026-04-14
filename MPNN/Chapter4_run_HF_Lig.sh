#!/bin/bash
#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --job-name=LigMPNN
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:05:00
#SBATCH --mem=10GB
#SBATCH --account=xxxx


run.py \
	--model_type "ligand_mpnn" \
	--pdb_path "./inputs/HF/m2-4D2_flav.pdb" \
	--out_folder "./outputs/HF/S1L1" \
	--redesigned_residues "A6 A10 A13 A16 A19 A20 A23 A24 A26 A29 A30 A31 A33 A34 A36 A38 A40 A41 A42 A44 A45 A48 A49 A51 A52 A56 A64 A68 A71 A74 A78 A81 A82 A87 A92 A95 A99 A102 A103 A106 A107 A109 A110" \
	--omit_AA "HCWM" \
	--batch_size 250
