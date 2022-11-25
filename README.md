# Gene_tree_from_fasta_pipeline

Snakemake pipeline for selecting gene sequences from select species within fasta files, aligning using mafft, and generating high quality gene trees using iqtree.

#### To run pipeline:
- Place input fasta files ```<tree_name>.fa``` in ```input```
- Update tree names, select species toggle, and species names in ```Gene_tree_from_fasta_config.yaml``` as directed in file
- Activate a conda environment with snakemake installed
- Run the following command:
```
snakemake -s Gene_tree_from_fasta_snakefile.smk --cores 10 --use-conda
```
#### Output:
- Directory containing iqtree output for each input file, within output ```trees``` directory
