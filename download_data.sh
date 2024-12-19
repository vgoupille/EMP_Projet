#! /bin/bash
#SBATCH --job-name=bp
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[valentin.goupille@etudiant.univ-rennes.fr]

#création du dossier raw_data dans le dossier Projet
#le fichier raw data contiendra les données téléchargées
mkdir /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data

# Téléchargement des données :
# Les données sont téléchargées depuis le site ftp://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/
#Il y a 17 espèces différentes, pour chaque espèce, on télécharge le fichier fasta contenant les séquences protéiques

#Il s'agit de 15 plantes modèles ou de plantes cultivées : monocotylédones et dicotylédones ainsi que 2 outgroups (Amborella trichopoda et Marchantia polymorpha)

wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/arabidopsis_thaliana/pep/Arabidopsis_thaliana.TAIR10.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Arabidopis_thaliana.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/oryza_sativa/pep/Oryza_sativa.IRGSP-1.0.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Oryza_sativa.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/triticum_aestivum/pep/Triticum_aestivum.IWGSC.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Triticum_aestivum.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/glycine_max/pep/Glycine_max.Glycine_max_v2.1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Glycine_max.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/hordeum_vulgare/pep/Hordeum_vulgare.MorexV3_pseudomolecules_assembly.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Hordeum_vulgare.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/zea_mays/pep/Zea_mays.Zm-B73-REFERENCE-NAM-5.0.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Zea_mays.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/solanum_tuberosum/pep/Solanum_tuberosum.SolTub_3.0.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Solanum_tuberosum.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/cucumis_sativus/pep/Cucumis_sativus.ASM407v2.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Cucumis_sativus.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/capsicum_annuum/pep/Capsicum_annuum.ASM51225v2.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Capsicum_annum.fa.gz
wget https://ftp.ebi.ac.uk//ensemblgenomes/pub/plants/current/fasta/beta_vulgaris/pep/Beta_vulgaris.RefBeet-1.2.2.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Beta_vulgaris.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/daucus_carota/pep/Daucus_carota.ASM162521v1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Daucus_carota.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/citrullus_lanatus/pep/Citrullus_lanatus.Cla97_v1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Citrillus_lanatus.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/brassica_oleracea/pep/Brassica_oleracea.BOL.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Brassica_oleracea.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/coffea_canephora/pep/Coffea_canephora.AUK_PRJEB4211_v1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Coffea_canephora.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/malus_domestica_golden/pep/Malus_domestica_golden.ASM211411v1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Malus_domestica.fa.gz
wget  https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/marchantia_polymorpha/pep/Marchantia_polymorpha.MpTak1_v7.1.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Marchantia_polymorpha.fa.gz
wget  https://ftp.ebi.ac.uk/ensemblgenomes/pub/plants/current/fasta/amborella_trichopoda/pep/Amborella_trichopoda.AMTR1.0.pep.all.fa.gz -O /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/Amborella_trichopoda.fa.gz


# ajouter des vérifications pour vérifier que les fichiers ont bien été téléchargés
for file in /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data/*.fa.gz; do
    if [ ! -f "$file" ]; then
        echo "Le fichier $file n'a pas été téléchargé correctement."
        exit 1
    fi
done

#Décompression des fichiers qui étaient compressés en .gz
gzip -d ./raw_data/*.fa.gz


