#! /bin/bash
#SBATCH --job-name=species_rax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr

### SPECIESRAX (PART OF GENERAX)

# Ce script utilise GeneRax pour inférer un arbre d'espèces (SpeciesRax) à partir d'arbres de gènes.

#############################################################################################################

### Chargement des outils nécessaires
. /local/env/envpython-3.9.5.sh # Python
. /local/env/envconda.sh # Conda

# Activation de l'environnement conda contenant GeneRax
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/env

#############################################################################################################

mkdir -p /home/genouest/tp_emp_tps_40958/tp60004/Projet/Output_generax

### Définition des chemins
trees_folder="/home/genouest/tp_emp_tps_40958/tp60004/Projet/arbres/"  # Répertoire contenant les arbres de gènes
family_file="/home/genouest/tp_emp_tps_40958/tp60004/Projet/Output_generax/fichier_famille.conf"  # Fichier famille généré par GeneRax
output_prefix="/home/genouest/tp_emp_tps_40958/tp60004/Projet/Output_generax/resultats_speciesrax"  # Préfixe des fichiers de sortie
generax_script="/home/genouest/tp_emp_tps_40958/tp60004/Projet/script/build_family_file.py"  # Script de génération de fichier famille
generax_bin="/home/genouest/tp_emp_tps_40958/tp60004/Projet/env/bin/generax"  # Chemin vers l'exécutable GeneRax

# Paramètres de reconstruction
rec_model="UndatedDTL"  # Modèle de réconciliation
species_tree="MiniNJ"  # Arbre d'espèces initial

#############################################################################################################

### Étape 1 : Création du fichier famille
if [ ! -f "$family_file" ]; then
    echo "Création du fichier famille pour GeneRax..."
    python "$generax_script" \
        NONE \
        "$trees_folder" \
        NONE \
        NONE \
        "$family_file"
else
    echo "Le fichier famille existe déjà : $family_file"
fi

#############################################################################################################

### Étape 2 : Exécution de GeneRax
if [ ! -d "$output_prefix" ]; then
    echo "Lancement de SpeciesRax avec GeneRax..."
    $generax_bin --families "$family_file" \
        --rec-model "$rec_model" \
        --prefix "$output_prefix" \
        --strategy SKIP \
        --si-strategy HYBRID \
        --species-tree "$species_tree" \
        --si-estimate-bl \
        --si-quartet-support \
        --prune-species-tree \
        --per-family-rates
        # Paramètres optionnels : décommenter si nécessaire
        # --dup-rate 0.6 \
        # --loss-rate 0.6 \
        # --transfer-rate 0.1
else
    echo "Les résultats existent déjà dans : $output_prefix"
fi

#############################################################################################################

echo "Analyse terminée ! Les résultats sont disponibles dans $output_prefix."




























