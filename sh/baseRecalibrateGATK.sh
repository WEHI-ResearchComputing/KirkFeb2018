## Use GATK tool BaseRecalibrator to update qual scores in bam files

module add gatk

cd $ALIGNDIR
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   gatk -T BaseRecalibrator -R $REFDIR/PlasmoDB-29_Pfalciparum3D7_Genome.fasta \
      -I 225-${fn}_nodup.bam   -o recal_data_${fn}.table \
      -knownSites $REFDIR/pfalcip_ensembl_knownvars.vcf 
      
   gatk -T PrintReads -R $REFDIR/PlasmoDB-29_Pfalciparum3D7_Genome.fasta \
      -I 225-${fn}_nodup.bam  -o 225-${fn}_recalQ.bam  \
      -BQSR recal_data_${fn}.table       
done
	
