## Use bowtie2 to align 4 sample's sequence files to the PlasmoDB v29 P. falciparum 3D7 reference

# module add bowtie2  # Needed for torquelord
# module add samtools
PAPDIR=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects
BASEDIR=$PAPDIR/malaria/cowman_lab/drug_resistance
DATADIR=$BASEDIR/drug225/sequence_data
ALIGNDIR=$BASEDIR/drug225/alignment
REFDIR=$PAPDIR/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7

# Align each pair to reference 
for fn in '225-1-B4_S1' '225-2-G11_S2' '225-3-D8_S3' '225-3-F5_S4'
do
    bowtie2 --sensitive-local --threads 2 \
      -x $REFDIR/PlasmoDB-29_Pfalciparum3D7_Genome  \
	  -1 $DATADIR/${fn}_R1.fastq.gz \
	  -2 $DATADIR/${fn}_R2.fastq.gz \
	  -S $ALIGNDIR/${fn}.sam  \
	  --rg-id $fn  \
      --rg "SM:$fn	PL:ILLUMINA"
    
# Convert to bam
    samtools view -b -o $ALIGNDIR/${fn}.bam $ALIGNDIR/${fn}.sam

## Use new version of sort
    samtools sort -o $ALIGNDIR/${fn}_s.bam -O bam -T ~/tmp/samsort -@ 3 $ALIGNDIR/${fn}.bam
    samtools index $ALIGNDIR/${fn}_s.bam

# Remove intermediate files
    if [ -f $ALIGNDIR/${fn}_s.bam ] 
      then rm $ALIGNDIR/${fn}.sam $ALIGNDIR/${fn}.bam
    fi
done
	
