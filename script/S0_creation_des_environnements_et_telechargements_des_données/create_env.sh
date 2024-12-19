#! /bin/bash
#SBATCH --job-name=conda
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr
. /local/env/envconda.sh

conda create -p /home/genouest/tp_emp_tps_40958/tp60004/Projet/Projet_env -c bioconda python=3.10 diamond=0.8.36 orthofinder mafft iqtree -y