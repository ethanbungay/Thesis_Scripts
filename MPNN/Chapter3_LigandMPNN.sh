#!/bin/bash
#SBATCH --account=xxxxx
#SBATCH --partition=veryshort
#SBATCH --cpus-per-task=14
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=06:00:00
#SBATCH --mem=10GB

python run.py \
        --pdb_path "./inputs/4D2pt5.pdb" \
        --out_folder "./outputs/FC-4D2_Outputs/Iteration1" \
	--model_type "ligand_mpnn" \
	--ligand_mpnn_use_side_chain_context 1 \
	--omit_AA "CH" \
	--fixed_residues "A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16 A17 A55 A56 A57 A58 A59 A60 A61 A62 A63 A64 A65 A66 A67 A68 A69 A70 A71 A72 A73 A74 A75 A76 A77 A78 A79 A80 A81 A82 A83 A84 A85 A86 A87 A88 A89 A127 A128 A129 A130 A131 A132 A133 A134 135 A136 A137 A138 A139 A140" \
	--batch_size 250 
