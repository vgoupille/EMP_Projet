# -*- coding: utf-8 -*-
# Script pour résumer les résultats d'OrthoFinder
# L'objectif est de résumer les statistiques globales produites par OrthoFinder dans un fichier CSV

import os  # Pour gérer les fichiers et répertoires
import pandas as pd  # Pour lire et écrire des données tabulaires
import argparse  # Pour gérer les arguments de la ligne de commande


def extract_statistics(input_tsv, output_csv=None):
    """Extrait les statistiques globales d'OrthoFinder et les sauvegarde dans un fichier CSV."""
    # Vérifier que le fichier TSV existe
    if not os.path.exists(input_tsv):
        print(f"Erreur : Le fichier {input_tsv} n'existe pas.")
        return

    # Lire le fichier TSV avec pandas
    try:
        stats = pd.read_csv(
            input_tsv,
            sep="\t",
            index_col=0,
            header=None,
            on_bad_lines="warn",  # Remplacer 'error_bad_lines' par 'on_bad_lines'
            quotechar='"',
        )
    except Exception as e:
        print(f"Erreur lors de la lecture du fichier TSV : {e}")
        return

    # Vérifier que les colonnes nécessaires sont présentes
    if 1 not in stats.columns:
        print("Erreur : Le fichier TSV ne contient pas les colonnes attendues.")
        return

    # Extraire les informations pertinentes et convertir les valeurs en numériques
    try:
        assigned_genes = pd.to_numeric(
            stats.loc["Number of genes in orthogroups", 1], errors="coerce"
        )
        total_genes = pd.to_numeric(stats.loc["Number of genes", 1], errors="coerce")
        orthogroups = pd.to_numeric(
            stats.loc["Number of orthogroups", 1], errors="coerce"
        )
        g50 = pd.to_numeric(stats.loc["G50 (assigned genes)", 1], errors="coerce")
        o50 = pd.to_numeric(stats.loc["O50 (all genes)", 1], errors="coerce")
        all_species_orthogroups = pd.to_numeric(
            stats.loc["Number of orthogroups with all species present", 1],
            errors="coerce",
        )
        single_copy_orthogroups = pd.to_numeric(
            stats.loc["Number of single-copy orthogroups", 1], errors="coerce"
        )
    except KeyError as e:
        print(f"Erreur : Une clé attendue est absente dans le fichier TSV ({e}).")
        return

    # Calculer le pourcentage de gènes assignés à des orthogroupes
    try:
        if total_genes != 0:
            percent_assigned = (assigned_genes / total_genes) * 100
        else:
            print(
                "Erreur : Le nombre total de gènes est égal à 0, impossible de calculer le pourcentage."
            )
            return
    except TypeError as e:
        print(f"Erreur de type lors du calcul du pourcentage de gènes assignés : {e}")
        return

    # Afficher les résultats
    print("Résultats globaux d'OrthoFinder :")
    print(f"- Nombre total de gènes : {total_genes}")
    print(
        f"- Nombre de gènes assignés à des orthogroupes : {assigned_genes} ({percent_assigned:.2f}%)"
    )
    print(f"- Nombre total d'orthogroupes : {orthogroups}")
    print(f"- G50 (nombre minimal de gènes dans 50% des orthogroupes) : {g50}")
    print(f"- O50 (nombre minimal d'orthogroupes contenant 50% des gènes) : {o50}")
    print(f"- Orthogroupes contenant toutes les espèces : {all_species_orthogroups}")
    print(
        f"- Orthogroupes contenant toutes les espèces et uniquement des gènes à copie unique : {single_copy_orthogroups}"
    )

    # Si aucun fichier de sortie n'est fourni, créer un chemin par défaut dans le dossier parent
    if output_csv is None:
        parent_dir = os.path.dirname(input_tsv)  # Répertoire parent du fichier TSV
        output_csv = os.path.join(parent_dir, "orthofinder_summary.csv")

    # Sauvegarder les statistiques dans un fichier CSV
    summary = {
        "Metric": [
            "Total genes",
            "Genes assigned to orthogroups",
            "Percentage of genes assigned",
            "Total orthogroups",
            "G50",
            "O50",
            "Orthogroups with all species",
            "Orthogroups with all species and single-copy genes",
        ],
        "Value": [
            total_genes,
            assigned_genes,
            f"{percent_assigned:.2f}%",
            orthogroups,
            g50,
            o50,
            all_species_orthogroups,
            single_copy_orthogroups,
        ],
    }

    try:
        pd.DataFrame(summary).to_csv(output_csv, index=False)
        print(f"\nLes statistiques ont été sauvegardées dans : {output_csv}")
    except Exception as e:
        print(f"Erreur lors de la sauvegarde du fichier CSV : {e}")


if __name__ == "__main__":  # Si le script est exécuté en tant que programme autonome
    # Gestion des arguments en ligne de commande
    parser = argparse.ArgumentParser(
        description="Résumé des statistiques d'OrthoFinder"
    )
    parser.add_argument(
        "input_tsv",
        type=str,
        help="Fichier TSV contenant les résultats globaux d'OrthoFinder (Statistics_Overall.tsv)",
    )
    parser.add_argument(
        "--output_csv",
        type=str,
        default=None,
        help="Chemin du fichier CSV où sauvegarder les résultats (facultatif). Si non précisé, il sera créé dans le dossier parent du TSV.",
    )

    args = parser.parse_args()

    # Appeler la fonction avec les arguments
    extract_statistics(args.input_tsv, args.output_csv)

    # Exemple d'utilisation:
    # python extract_summary_results_orthofinder.py /home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/Comparative_Genomics_Statistics/Statistics_Overall.tsv
