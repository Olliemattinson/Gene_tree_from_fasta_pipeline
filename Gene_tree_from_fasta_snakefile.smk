configfile: 'Gene_tree_from_fasta_config.yaml'

rule all:
    input:
        expand('trees/{treeName}.treefile',treeName=config['treeNames'])

if config['selectSpecies']=='TRUE':
    rule trim_fasta_by_species:
        input:
            fasta='input/{treeName}.fa'
        params:
            speciesList=expand('{species}',species=config['speciesNames']),
            outputFileName='trimmed_fastas/{treeName}_select_species.fa'
        conda:
            'envs/Gene_tree_from_fasta_env.yaml'
        output:
            fasta='trimmed_fastas/{treeName}_select_species.fa'
        shell:
            'python Trim_fasta_by_species.py {input.fasta} {params.outputFileName} {params.speciesList}'

    rule align:
        input:
            fasta='trimmed_fastas/{treeName}_select_species.fa'
        conda:
            'envs/Gene_tree_from_fasta_env.yaml'
        output:
            alignment='alignments/{treeName}_select_species_alignment.fa'
        shell:
            'mafft-linsi {input.fasta} > {output.alignment}'

    rule generate_tree:
        input:
            alignment='alignments/{treeName}_select_species_alignment.fa'
        params:
            alrt=1000,
            bb=1000,
            nt='AUTO',
            cores='AUTO',
            outputDir='trees',
            outputPrefix='trees/{treeName}'
        conda:
            'envs/Gene_tree_from_fasta_env.yaml'
        output:
            tree='trees/{treeName}.treefile'
        shell:
            'mkdir -p {params.outputDir};'
            'iqtree -s {input.alignment} -alrt {params.alrt} -bb {params.bb} -nt {params.nt} -T {params.cores} -pre {params.outputPrefix}'

elif config['selectSpecies']=='FALSE':
    rule align:
        input:
            fasta='input/{treeName}.fa'
        conda:
            'envs/Gene_tree_from_fasta_env.yaml'
        output:
            alignment='alignments/{treeName}_alignment.fa'
        shell:
            'mafft-linsi {input.fasta} > {output.alignment}'

    rule generate_tree:
        input:
            alignment='alignments/{treeName}_alignment.fa'
        params:
            alrt=1000,
            bb=1000,
            nt='AUTO',
            cores='AUTO',
            outputDir='trees',
            outputPrefix='trees/{treeName}'
        conda:
            'envs/Gene_tree_from_fasta_env.yaml'
        output:
            tree='trees/{treeName}.treefile'
        shell:
            'mkdir -p {params.outputDir};'
            'iqtree -s {input.alignment} -alrt {params.alrt} -bb {params.bb} -nt {params.nt} -T {params.cores} -pre {params.outputPrefix}'
