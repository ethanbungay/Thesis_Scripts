#!/bin/bash
#SBATCH --nodes=1
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH --time=0-03:00:00
#SBATCH --mem=50GB
#SBATCH --output=chai1_test
#SBATCH --account=chem023222

python batch_aggregate_rank_v2.py