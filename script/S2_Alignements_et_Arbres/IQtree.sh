#!/bin/bash
#SBATCH --job-name=Iqtree
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G

### Chargement des outils nécessaires
. /local/env/envpython-3.9.5.sh # Python
. /local/env/envconda.sh # Conda

# Activation de l'environnement conda
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/env

# Répertoire d'entrée contenant les fichiers d'alignement
INDIR="/home/genouest/tp_emp_tps_40958/tp60004/Projet/alignements_filtered_orthogroups_min17_max30"
OUTDIR="/home/genouest/tp_emp_tps_40958/tp60004/Projet/arbres"
# Nombre de threads
THREADS=4

mkdir -p $OUTDIR

# Boucle sur tous les fichiers du répertoire d'entrée
ls $INDIR | sort -R | while read file; do
    # Extraire l'ID du fichier sans son extension
    ID=`basename $file .fa`
    
    # Construire un arbre avec IQ-TREE en choisissant automatiquement le meilleur modèle
    iqtree -T $THREADS -s "$INDIR/$file" -m MFP -pre "$OUTDIR/$ID"
done

echo "All trees have been generated!"




conda deactivate