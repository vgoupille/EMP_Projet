#!/bin/bash
#SBATCH --job-name=MAFFT
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr
#SBATCH --mem=64G

# Chargement des outils nécessaires
. /local/env/envconda.sh # Conda

# Activation de l'environnement conda
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/Projet_env



# Définir les répertoires d'entrée et de sortie
input_dir="/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/EMP_filtered_orthogroups_min17_max30"
output_dir="/home/genouest/tp_emp_tps_40958/tp60004/Projet/alignements_filtered_orthogroups_min17_max30"

# Créer le répertoire de sortie s'il n'existe pas encore
mkdir -p "$output_dir"

# Boucle pour traiter chaque fichier de séquences
for file in "$input_dir"/*.fa; do
    # Construire le chemin du fichier de sortie
    output_file="$output_dir/$(basename "$file" .fa)_aligned.fa"
    
    # Exécuter MAFFT avec les options spécifiées
    echo "Aligning $(basename "$file")..."
    mafft-linsi --thread 4 --anysymbol "$file" > "$output_file"
done

echo "Alignments completed! Results saved in $output_dir."

# Désactiver l'environnement Conda
conda deactivate















# Répertoires d'entrée et de sortie
#INDIR="/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/EMP_filtered_orthogroups_min17_max30"
#OUTDIR="/home/genouest/tp_emp_tps_40958/tp60004/Projet/alignements_filtered_orthogroups_min17_max30"

# Création du répertoire de sortie s'il n'existe pas
#mkdir -p "$OUTDIR"

# Traitement des fichiers .fasta
#ls "$INDIR"/*.fa | while read file; do
    # Extraction de l'ID du fichier sans extension
#   ID=$(basename "$file" .fa)

    # Alignement précis avec MAFFT-LINSI
#   output_file="$OUTDIR/${ID}_mafft_linsi.fa"
#   if [ ! -f "$output_file" ]; then
#        echo "Alignement avec MAFFT-LINSI pour $ID..."
#       mafft-linsi --thread 4 --anysymbol "$file" > "$output_file"
#       echo "Alignement terminé pour $ID."
#    else
#        echo "Fichier d'alignement déjà existant pour $ID. Passage au fichier suivant."
#    fi
#done

#echo "Analyse terminée ! Les résultats sont disponibles dans $OUTDIR."

