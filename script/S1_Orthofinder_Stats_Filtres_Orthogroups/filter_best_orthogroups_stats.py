# -*- coding: utf-8 -*-

# Script pour filtrer les orthogroupes en fonction du nombre de séquences et d'espèces

import os
import argparse
import csv
from Bio import SeqIO
import shutil


# Fonction pour compter les séquences et les espèces
def count_sequences_and_species(fasta_file):
    """Compte le nombre de séquences et d'espèces dans un fichier fasta"""
    sequences = list(SeqIO.parse(fasta_file, "fasta"))
    num_sequences = len(sequences)
    species = {seq.id.split("_")[0] for seq in sequences}  # Espèces identifiées
    num_species = len(species)
    return num_sequences, num_species


# Fonction principale
def filter_orthogroups(
    input_folder, output_folder, min_seq, max_seq, min_sp, stats_csv
):
    """Filtre les orthogroupes en fonction des critères définis"""
    if stats_csv is None:
        stats_csv = os.path.join(
            os.path.dirname(output_folder), "filtered_orthogroups_stats.csv"
        )
    os.makedirs(output_folder, exist_ok=True)

    total_orthogroups = 0
    retained_orthogroups = 0
    stats = []

    for file_name in os.listdir(input_folder):
        input_path = os.path.join(input_folder, file_name)
        if file_name.endswith(".fa"):
            total_orthogroups += 1
            num_sequences, num_species = count_sequences_and_species(input_path)

            if min_seq <= num_sequences <= max_seq and num_species >= min_sp:
                retained_orthogroups += 1
                print(
                    f"Retenu: {file_name} ({num_sequences} séquences, {num_species} espèces)"
                )
                output_path = os.path.join(output_folder, file_name)
                shutil.copy(input_path, output_path)
                status = "retained"
            else:
                print(
                    f"Écarté: {file_name} ({num_sequences} séquences, {num_species} espèces)"
                )
                status = "discarded"

            stats.append(
                {
                    "Orthogroup": file_name,
                    "Num_Sequences": num_sequences,
                    "Num_Species": num_species,
                    "Status": status,
                }
            )

    # Écriture du fichier CSV
    with open(stats_csv, "w", newline="") as csvfile:
        fieldnames = ["Orthogroup", "Num_Sequences", "Num_Species", "Status"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(stats)

    # Affichage des statistiques globales
    print(f"Filtrage terminé. Les fichiers sont stockés dans {output_folder}")
    print(f"Statistiques enregistrées dans {stats_csv}")
    print(
        f"Total orthogroups: {total_orthogroups}, Retenus: {retained_orthogroups}, Écartés: {total_orthogroups - retained_orthogroups}"
    )


# Gestion des arguments
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Filtrer des orthogroupes en fonction du nombre de séquences et d'espèces."
    )
    parser.add_argument(
        "input_folder",
        help="Répertoire contenant les fichiers d'orthogroupes à analyser.",
    )
    parser.add_argument(
        "output_folder", help="Répertoire où stocker les orthogroupes filtrés."
    )
    parser.add_argument(
        "stats_csv", help="Fichier CSV pour enregistrer les statistiques."
    )
    parser.add_argument(
        "--min_seq",
        type=int,
        default=17,
        help="Nombre minimum de séquences par orthogroupe.",
    )
    parser.add_argument(
        "--max_seq",
        type=int,
        default=30,
        help="Nombre maximum de séquences par orthogroupe.",
    )
    parser.add_argument(
        "--min_sp",
        type=int,
        default=17,
        help="Nombre minimum d'espèces par orthogroupe.",
    )

    args = parser.parse_args()
    filter_orthogroups(
        args.input_folder,
        args.output_folder,
        args.min_seq,
        args.max_seq,
        args.min_sp,
        args.stats_csv,
    )
