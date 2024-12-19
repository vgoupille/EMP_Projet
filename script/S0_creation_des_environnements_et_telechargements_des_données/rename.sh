#! /bin/bash
#SBATCH --job-name=bp
#SBATCH --mail-type=ALL
#SBATCH --mail-user=valentin.goupille@etudiant.univ-rennes.fr

#Script pour renommer les sequences fasta de chaque espèce de façon simplifiée
#le nom de la sequence fasta devient le nom de l'espèce suivi de l'identifiant de la sequence fasta


#exemple de la premiere sequence fasta à renommer dans le fichier fasta: Amborella_trichopoda.fa

#>ERN07632 pep supercontig:AMTR1.0:AmTr_v1.0_scaffold00796:4861:5063:1 gene:AMTR_s00796p00010580 transcript:ERN07632 gene_biotype:protein_coding transcript_biotype:protein_coding description:hypothetical protein
#LQKSSCDNRVVEVGRLRMRLRGFGGSEVEDRRREEELGPAFKTRRSFPFIRLEGNLLGSD
#GPAGKA

#renommage de la sequence fasta:
#elle devient simplement:

#>Amborella.trichopoda_ERN07632
#LQKSSCDNRVVEVGRLRMRLRGFGGSEVEDRRREEELGPAFKTRRSFPFIRLEGNLLGSD
#GPAGKA

###############################################################################################################################################################


#creation de dossier de sortie avec les fichiers renommés:  output_rename
mkdir -p /home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data_rename

#input_dir: dossier contenant les fichiers fasta à renommer
input_dir="/home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data"

#output_dir: dossier de sortie contenant les fichiers fasta renommés , ici raw_data_rename
output_dir="/home/genouest/tp_emp_tps_40958/tp60004/Projet/raw_data_rename"


#boucle pour renommer les fichiers fasta
for f in "$input_dir"/*.fa ; do #parcourir les fichiers fasta dans le dossier input_dir
	speciesID=$(basename "$f" .fa | sed 's/_/./') #recuperer le nom de l'espèce
        echo -e "$f -> $speciesID" #afficher le nom de l'espèce
	output_file="$output_dir/$(basename "$f")" #nom du fichier de sortie
	sed "s/^>/>${speciesID}\_/g" "$f" | sed 's/\s.*$//' > "$output_file" #renommer les sequences fasta
done

echo "Renommage terminé. Les fichiers sont stockés dans le dossier : $output_dir" 


