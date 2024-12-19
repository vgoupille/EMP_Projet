#!/bin/bash
#SBATCH --job-name=python_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr


. /local/env/envpython-3.9.5.sh
conda activate /home/genouest/tp_emp_tps_40958/tp60004/Projet/env


# execute the python script to filter the orthogroups

#filtre les orthogroupes en fonction du nombre de séquences et du nombre d'espèces

#python /home/genouest/tp_emp_tps_40958/tp60004/Projet/script/filter_best_orthogroups_stats.py \
#/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/Orthogroup_Sequences \
#/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/EMP_filtered_orthogroups_min17_max50 \
#/home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/orthogroups_stats_min17_max50.csv \
#--min_seq 17 --max_seq 50 --min_sp 17


#filtre les orthogroupes en fonction du nombre de séquences et du nombre d'espèces 30 max et 17 min de séquences et d'espèces
python /home/genouest/tp_emp_tps_40958/tp60004/Projet/script/filter_best_orthogroups_stats.py /home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/Orthogroup_Sequences /home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/EMP_filtered_orthogroups_min17_max30 /home/genouest/tp_emp_tps_40958/tp60004/Projet/orthoFinder_output/Results_Dec15/orthogroups_stats_min17_max30.csv --min_seq 17 --max_seq 30 --min_sp 17

conda deactivate

conda deactivate