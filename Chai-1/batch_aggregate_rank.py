from pathlib import Path
import numpy as np
import torch
from chai_lab.chai1 import run_inference  # Replace with the actual library import
from Bio import SeqIO
import csv

############## v2 aggregate - sorting by aggregate score, a weighted average of the confidence metrics #########################
############## updated to include placeholders to make userface more friendly ##################################################

INPUT_FASTA = Path("/path/to/fasta/file.fa")
OUTPUT_BASE_DIR = Path("/path/to/output/directory")
AGGREGATE_RANK_FILE = OUTPUT_BASE_DIR / "highest_aggregate_scores.csv"

# Function to parse the FASTA file and extract protein and ligand data
def parse_fasta(fasta_file):
    protein_data = []
    current_protein = None

    for record in SeqIO.parse(fasta_file, "fasta"):
        description = record.description
        sequence = str(record.seq)

        if "protein|name=" in description:
            if current_protein:
                protein_data.append(current_protein)
            protein_name = description.split("name=")[1]
            current_protein = {"name": protein_name, "protein_sequence": sequence, "ligands": []}
        elif "ligand|name=" in description and current_protein:
            ligand_name = description.split("name=")[1]
            current_protein["ligands"].append({"name": ligand_name, "smiles": sequence})

    if current_protein:
        protein_data.append(current_protein)

    return protein_data


def clean_and_expand_data(data):
    if isinstance(data, np.ndarray):
        if data.ndim == 0:
            return data.item()
        elif data.ndim == 1:
            return list(data)
        elif data.ndim == 2:
            return data.flatten().tolist()
    return data


def extract_scores_to_dict(npz_file):
    if not npz_file.exists():
        print(f"File {npz_file} not found.")
        return {}

    data = np.load(npz_file)
    scores = {"file": npz_file.stem}

    metrics_to_extract = ["aggregate_score", "iptm", "ptm"]
    for metric in metrics_to_extract:
        if metric in data:
            scores[metric] = clean_and_expand_data(data[metric])

    return scores


# Main script
protein_data = parse_fasta(INPUT_FASTA)

for protein in protein_data:
    # Create individual FASTA-like input for each protein
    fasta_content = f">protein|name={protein['name']}\n{protein['protein_sequence']}\n"
    #for ligand in protein["ligands"]:
        #fasta_content += f">ligand|name={ligand['name']}\n{ligand['smiles']}\n"

    # Define input and output paths for this protein
    fasta_path = Path(f"./inputs/{protein['name']}.fasta")
    output_dir = OUTPUT_BASE_DIR / protein['name']
    fasta_path.parent.mkdir(parents=True, exist_ok=True)
    output_dir.mkdir(parents=True, exist_ok=True)

    # Write the FASTA content to a file
    fasta_path.write_text(fasta_content)

    # Run inference
    candidates = run_inference(
        fasta_file=fasta_path,
        output_dir=output_dir,
        num_trunk_recycles=3,
        num_diffn_timesteps=200,
        seed=42,
        device=torch.device("cuda:0"),
        use_esm_embeddings=True,
    )

    # Extract scores from .npz files
    npz_files = list(output_dir.glob("*.npz"))
    combined_scores_file = output_dir / "combined_scores.csv"

    # Combine scores into a CSV file
    with combined_scores_file.open(mode="w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=["file", "aggregate_score", "iptm", "ptm"])
        writer.writeheader()
        for npz_file in npz_files:
            scores = extract_scores_to_dict(npz_file)
            if scores:
                writer.writerow(scores)

    print(f"Processed {protein['name']} - Combined scores saved to {combined_scores_file}")

    # Remove the temporary FASTA file after processing
    fasta_path.unlink()

# Aggregate highest aggregate scores from all combined_scores.csv files
all_combined_scores = []

for protein in protein_data:
    output_dir = OUTPUT_BASE_DIR / protein["name"]
    combined_scores_file = output_dir / "combined_scores.csv"

    if combined_scores_file.exists():
        # Read combined_scores.csv and find the line with the highest aggregate score
        with combined_scores_file.open(mode="r") as file:
            reader = csv.DictReader(file)
            highest_aggregate_row = None
            for row in reader:
                # Convert "aggregate_score" to a float, handling brackets if still present
                aggregate_score = float(row["aggregate_score"].strip("[]"))
                if highest_aggregate_row is None or aggregate_score > float(highest_aggregate_row["aggregate_score"].strip("[]")):
                    highest_aggregate_row = row

            if highest_aggregate_row:
                # Add the directory name as the first column
                highest_aggregate_row["directory"] = protein["name"]
                all_combined_scores.append(highest_aggregate_row)

# Write the highest aggregate scores to a CSV file
with AGGREGATE_RANK_FILE.open(mode="w", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=["directory", "file", "aggregate_score", "iptm", "ptm"])
    writer.writeheader()

    # Sort scores by aggregate score in descending order before writing
    sorted_scores = sorted(all_combined_scores, key=lambda x: float(x["aggregate_score"].strip("[]")), reverse=True)
    writer.writerows(sorted_scores)

print(f"Highest aggregate scores saved to {AGGREGATE_RANK_FILE}")
