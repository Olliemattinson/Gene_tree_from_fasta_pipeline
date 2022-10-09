import sys
from Bio import SeqIO

inputFile = sys.argv[1]
outputFileName = sys.argv[2]
speciesList = sys.argv[3:]

input=open(inputFile,'r')
output=open(outputFileName,'w')
for gene in SeqIO.parse(input,'fasta'):
    geneName=str(gene.id)
    geneSequence=str(gene.seq)
    for speciesName in speciesList:
        if speciesName in geneName:
            output.write('>'+geneName+'\n')
            output.write(geneSequence+'\n')

input.close()
output.close()
