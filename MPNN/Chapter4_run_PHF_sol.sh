#!/bin/bash
#SBATCH --partition=test
#SBATCH --nodes=1
#SBATCH --job-name=SolMPNN
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:15:00
#SBATCH --mem=50GB
#SBATCH --account=xxxxx

run.py \
	--model_type "soluble_mpnn" \
	--pdb_path "./inputs/PHF_4D2pt5.pdb" \
	--out_folder "./outputs/PHF/S1L0" \
	--fixed_residues "A1 A16 A17 A20 A23 A26 A27 A28 A30 A31 A32 A36 A40 A41 A42 A43 A44 A45 A46 A47 A48 A51 A52 A55 A56 A58 A59 A62 A81 A88 A89 A92 A95 A102 A103 A108 A109 A112 A113 A116 A117 A120 A123 A124 A127 A128 A130 A131" \
	--omit_AA "HC" \
	--batch_size 250
