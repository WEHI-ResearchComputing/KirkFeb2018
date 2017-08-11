## Use Picard MarkDuplicates to remove duplicates which are sequencing artefacts

PAPDIR=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects
BASEDIR=$PAPDIR/malaria/cowman_lab/drug_resistance
ALIGNDIR=$BASEDIR/drug225/alignment

module add picard-tools 

cd $ALIGNDIR
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   MarkDuplicates I=225-${fn}_s.bam O=225-${fn}_nodup.bam M=${fn}_duplic.metrics \
      REMOVE_DUPLICATES=TRUE
done
	
