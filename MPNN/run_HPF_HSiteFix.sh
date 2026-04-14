#!/bin/bash
#SBATCH --account=chem023222
#SBATCH --partition=veryshort
#SBATCH --cpus-per-task=14
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=06:00:00
#SBATCH --mem=10GB

python run.py \
        --pdb_path "./inputs/HPF_L/HSite-Fix/id44_holo.pdb" \
        --out_folder "./outputs/HPF_outputs/H_Site_Fixed/Iteration2" \
	--model_type "ligand_mpnn" \
	--ligand_mpnn_use_side_chain_context 1 \
	--omit_AA "CH" \
	--fixed_residues "A8 A12 A43 A62 A65 A81 A85 A131 A134 A137" \
	--batch_size 100 
