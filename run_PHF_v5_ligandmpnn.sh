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
	--model_type "ligand_mpnn" \
	--checkpoint_path_sc "./model_params/ligandmpnn_sc_v_32_002_16.pt" \
	--pdb_path "./inputs/PHF_4D2pt5/PHF_XF_v5pt3_biases_pt3_ID145.pdb" \
	--out_folder "./outputs/PHF_4D2pt5/XstalFlavin_v5pt3_biases_pt4" \
	--bias_AA_per_residue "./inputs/PHF_4D2pt5/PHF_4D2pt5_v5_XstalFlavOxyRenumb_biaspt4.json" \
	--fixed_residues "A1 A16 A44 A54 A88 A126" \
	--omit_AA "HC" \
	--batch_size 250
