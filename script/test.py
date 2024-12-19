from Bio import Phylo

# Charger l'arbre
tree = Phylo.read(
    "/Users/valentingoupille/Documents/GitHub/EMP_Projet/Resultats/OG0009680_aligned_reconciliated.xml",
    "phyloxml",
)

# Liste des outgroups
outgroup_names = ["Amborella.trichopoda", "Marchantia.polymorpha"]
outgroups = [tree.find_any(name) for name in outgroup_names]

# Trouver l'ancêtre commun des outgroups
mrca = tree.common_ancestor(outgroups)

# Rerooter à cet ancêtre
tree.root_with_outgroup(mrca)

# Sauvegarder l'arbre rerooté
Phylo.write(tree, "rerooted_phylogeny.xml", "phyloxml")

# Visualiser l'arbre
Phylo.draw(tree)
