#!/bin/bash
#SBATCH --job-name=python_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr


. /local/env/envpython-3.9.5.sh
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/env



python /home/genouest/tp_emp_tps_40958/tp60004/Projet/script/extract_summary_results_orthofinder.py /home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/Comparative_Genomics_Statistics/Statistics_Overall.tsv

conda deactivate