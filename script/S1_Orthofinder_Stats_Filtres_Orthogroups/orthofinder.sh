#! /bin/bash
#SBATCH --job-name=conda
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr

#SBATCH --mem=64G

#    --cpus-per-task=10



### chargement des outils GenOuest
. /local/env/envpython-3.9.5.sh # python
. /local/env/envconda.sh # conda

# Activer l'environnement conda
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/env

#Script pour lancer OrthoFinder
#permets de lancer OrthoFinder sur le cluster de GenOuest
# OrthoFinder est un logiciel qui permet de trouver les orthogroupes et les orthologues à partir de séquences protéiques
# OrthoFinder utilise DIAMOND pour l'alignement des séquences
# Orthofinder utilise DendroBLAST pour la construction de l'arbre phylogénétique


# Activer l'environnement conda



# nombre de threads correspondant au nombre de coeurs alloués pour le calcul
threads=20
# Dossier contenant les fichiers fasta
#ici les fichiers fasta sont dans le dossier raw_data_rename
# il s'agit des fichiers fasta renommés de façon simplifiée
inputfolder="/home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data_rename"

# Dossier de sortie contenant les résultats de OrthoFinder
outputfolder="/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output3"

# Exécuter OrthoFinder
orthofinder -t $threads -M dendroblast -S diamond -1 -X -o $outputfolder -f $inputfolder 

#je veux rajouter un tsv avec les orthogroupes et les orthologues
#lancer orthofinder avec les paramètres spécifiés
# -t: nombre de threads
# -M: méthode de construction de l'arbre phylogénétique
# -S: méthode d'alignement des séquences
# -1: activer l'option de recherche des orthologues uniques
# -X: activer l'option de recherche des orthogroupes
# -o: dossier de sortie pour les résultats de OrthoFinder
# -f: dossier contenant les fichiers fasta à analyser
# orthofinder: commande pour lancer OrthoFinder

# Relancer OrthoFinder en reprenant là où il s'est arrêté
#orthofinder -t $threads -M dendroblast -S diamond -X -o $outputfolder -f $inputfolder

#timestamp=$(date +%Y%m%d_%H%M%S)
#temp_output="/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output_$timestamp"

#orthofinder -t $threads -M dendroblast -S diamond -X -o $temp_output -f $inputfolder

# Convertir les résultats en TSV
#orthofinder_results="$outputfolder/Results*/Orthogroups/Orthogroups.tsv"
#cp $orthofinder_results "$outputfolder/orthogroups_and_orthologues.tsv"

conda deactivate

#exemple de commande pour lancer le script
#sbatch --cpus-per-task=10 orthofinder.sh