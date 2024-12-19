#!/bin/bash
#SBATCH --job-name=conda  # Nom du job
#SBATCH --mail-type=ALL  # Notifications par email pour tous les états du job
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr  # Adresse email pour les notifications

# Chargement de l'environnement Conda
. /local/env/envconda.sh

# Définir le chemin de l'environnement Conda
env_dir="/home/genouest/tp_emp_tps_40958/tp60004/Projet/env"

# Vérifier si l'environnement existe déjà, sinon créer un nouvel environnement
if [ ! -d "$env_dir" ]; then
    echo "Création de l'environnement Conda dans : $env_dir"
    conda create -p "$env_dir" -c bioconda python=3.10 diamond=0.8.36 orthofinder mafft iqtree -y || { echo "Échec de la création de l'environnement Conda"; exit 1; }
else
    echo "L'environnement Conda existe déjà dans : $env_dir"
fi

# Activation de l'environnement Conda
echo "Activation de l'environnement Conda..."
conda activate "$env_dir" || { echo "Échec de l'activation de l'environnement Conda"; exit 1; }

# Installation des packages nécessaires
echo "Installation de pandas dans l'environnement Conda..."
conda install pandas -y || { echo "Échec de l'installation de pandas"; exit 1; }

# Optionnel : installer d'autres outils bioinformatiques si nécessaire
echo "Installation de Generax..."
conda install -c bioconda generax=2.0.4 -y || { echo "Échec de l'installation de Generax"; exit 1; }

# Installer OpenMPI
conda install -c conda-forge openmpi -y || { echo "Échec de l'installation de OpenMPI"; exit 1; }

# Confirmation de l'installation
echo "Environnement Conda prêt et packages installés avec succès dans : $env_dir"

# Désactivation de l'environnement Conda
conda deactivate