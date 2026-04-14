#!/bin/bash
#SBATCH --partition=test
#SBATCH --nodes=1
#SBATCH --job-name=LigMPNN
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:15:00
#SBATCH --mem=50GB
#SBATCH --account=chem023222


/user/work/dy19627/Anaconda3/envs/ligandmpnn_env2/bin/python3.11 run.py \
	--model_type "soluble_mpnn" \
	--pdb_path "./inputs/HF/HF_v2L1_ID76.pdb" \
	--out_folder "./outputs/HF_ShortMaquette/Attempt_2/S2" \
	--bias_AA "A:-1.0" \
	--fixed_residues "A1 A6 A9 A10 A13 A16 A19 A20 A23 A24 A26 A29 A30 A31 A33 A34 A36 A37 A38 A40 A41 A42 A44 A45 A47 A48 A49 A51 A52 A56 A64 A67 A68 A71 A74 A78 A81 A82 A87 A92 A95 A99 A102 A103 A105 A106 A107 A109 A110 A113" \
	--omit_AA "HC" \
	--batch_size 250
