#!/bin/bash
#SBATCH --partition=test
#SBATCH --nodes=1
#SBATCH --job-name=LigMPNN
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:15:00
#SBATCH --mem=50GB
#SBATCH --account=xxxx


run.py \
	--model_type "ligand_mpnn" \
	--pdb_path "./inputs/PHF_4D2pt5.pdb" \
	--out_folder "./outputs/PHF/S0L1" \
	--bias_AA_per_residue "./inputs/PHF_4D2pt5/PHF_4D2pt5_v5_XstalFlavOxyRenumb_biaspt4.json" \
	--fixed_residues "A17 A20 A23 A26 A27 A30 A31 A33 A35 A36 A37 A38 A39 A40 A41 A43 A45 A48 A51 A52 A55 A56 A58 A59 A62 A81 A85 A89 A92 A95 A99 A102 A103 A108 A109 A112 A113 A116 A120 A123 A124 A127 A128 A130 A131" \
	--omit_AA "HC" \
	--batch_size 250
