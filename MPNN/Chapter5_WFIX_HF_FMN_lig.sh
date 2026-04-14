#!/bin/bash
#SBATCH --partition=veryshort
#SBATCH --nodes=1
#SBATCH --job-name=LigMPNN
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:05:00
#SBATCH --mem=10GB
#SBATCH --account=xxxx


run.py \
	--model_type "ligand_mpnn" \
	--pdb_path "./inputs/HF_NonCov/m2-4D2_FMN.pdb" \
	--out_folder "./outputs/HF_FMN_WFIX/S1L1" \
	--redesigned_residues "A6 A10 A13 A16 A19 A20 A23 A24 A33 A34 A37 A38 A41 A44 A45 A48 A49 A52 A64 A68 A71 A74 A81 A92 A95 A99 A102 A103 A106 A110" \
	--omit_AA "HC" \
	--batch_size 250
