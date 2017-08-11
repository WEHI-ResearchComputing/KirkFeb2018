#!/bin/bash

## I want this to be a wehisan copy of a script that will run on HPC
## For now at least, I will not copy new bamfiles to torquelord but use symbolic links
## back to wehisan
## Parent on wehisan has been truncated to tape, so I will use copy available on 
## torquelord

PAPENDIR=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/
REFDIR=$PAPENDIR/reference_genomes/plasmodium
BASEDIR=$PAPENDIR/malaria/cowman_lab/drug_resistance
ALIGNDIR=$BASEDIR/drug225/alignment
REFERENCE=$REFDIR/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome
OUTDIR=$BASEDIR/drug225/variants/gridss/gridss_pairwise1.4.0_25May
OLDALIGN=/home/penington.j/localPf/alignments

# $1: output vcf
# $2+: input bams

module add java bwa R

gridss() {
	OUTPUT=$OUTDIR/$1
	if [[ ! -f $OUTPUT ]] ; then
		NEWDIR=$OUTDIR/gridss.$(basename $OUTPUT .vcf)
		mkdir -p $NEWDIR
		java \
			-ea \
			-Xmx31g \
			-Dsamjdk.create_index=true \
			-Dsamjdk.use_async_io_read_samtools=true \
			-Dsamjdk.use_async_io_write_samtools=true \
			-Dsamjdk.use_async_io_write_tribble=true \
			-Dsamjdk.compression_level=1 \
			-cp /wehisan/home/allstaff/c/cameron.d/bin/gridss-1.4.0-jar-with-dependencies.jar \
			gridss.CallVariants \
			TMP_DIR=$TMP \
			WORKING_DIR=$NEWDIR \
			INPUT=$2 INPUT_LABEL=$(basename $2 .bam) \
			INPUT=$3 INPUT_LABEL=$(basename $3 .bam) \
			OUTPUT=$OUTPUT \
			ASSEMBLY=$NEWDIR/assembly-$1.bam \
			REFERENCE_SEQUENCE=$REFERENCE.fasta \
			BLACKLIST=$REFDIR/12.0/CentromereTelomereRegions.bed \
			2>&1 | tee -a $NEWDIR/CallVariants.std.$$.log
	fi
}

for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   gridss ${fn}.vcf $OLDALIGN/3D7-merge-B3_S1-C5_S2.bam $ALIGNDIR/225-${fn}_nodup.bam
done
    
