## Pipeline for variant discovery for '225'-resistant strains of P. falciparum 3D7
## Project from Jenny Thompson and Alan Cowman,
## Copied from pipeline used Jan-Feb 2017 for 754 data
## 225 version started May 2017 by Jocelyn Sietsma Penington

# Sequencing data as fastq.gz files copied from GP_Transfer to
## PapenfussLab/projects/malaria/cowman_lab/drug_resistance/drug_225/sequence_data/
##

export PAPDIR=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects
export BASEDIR=$PAPDIR/malaria/cowman_lab/drug_resistance
export DATADIR=$BASEDIR/drug225/sequence_data
export ALIGNDIR=$BASEDIR/drug225/alignment
export TOOLDIR=$BASEDIR/drug225/analysis_tools
export REFDIR=$PAPDIR/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7

## Quality inspection of raw data:
mkdir $DATADIR/rawQC
fastqc -o $DATADIR/rawQC --noextract $DATADIR/*fastq.gz

## Alignment to ref v29 with bowtie2
nohup sh $TOOLDIR/align_each_bowtie2.sh > $ALIGNDIR/align.bowtie2.stats &

## Remove duplicate reads:
nohup sh $TOOLDIR/remove_duplicates.sh > remove_duplicates.out &
## After successful completion...
rm remove_duplicates.out
## files need to be re-indexed
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   samtools index $ALIGNDIR/225-${fn}_nodup.bam
done
## After successful completion...
rm $ALIGNDIR/225-*_s.bam*

## Not going to use GATK baseRecalibrate tool
## to adjust QUAL scores in bam files

mkdir $ALIGNDIR/align_metrics
## Collect insert-size, aka fragment-size, statistics
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   CollectInsertSizeMetrics I=$ALIGNDIR/225-${fn}_nodup.bam \
      O=$ALIGNDIR/align_metrics/${fn}_insert_size_metrics.txt \
      H=$ALIGNDIR/align_metrics/${fn}_insert_size_histogram.pdf
done

## Inspect coverage and gene bias:-
nohup sh $TOOLDIR/coverage.sh > $ALIGNDIR/coverage.out &

## Looking at bams in IGV is memory-hungry, and could be replaced by using tdf-format
## coverage files. 3D7-merge-B3_S1-C5_S2.bam done at command line.
## Default window size is 25bp
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do
   igvtools count $ALIGNDIR/225-${fn}_nodup.bam  \
   $ALIGNDIR/225-${fn}.tdf   \
   $REFDIR/PlasmoDB-29_Pfalciparum3D7_Genome.fasta
done

## Searching for variants ##
mkdir $BASEDIR/drug225/variants

## Using gridss. Although writing gridss_v1.4.0.sh in $TOOLDIR, I will run it on
## torquelord
mkdir $BASEDIR/drug225/variants/gridss
## ssh torquelord.hpc.wehi.edu
cd localPf
cp ~/origPf/drug225/analysis_tools/gridss_v1.4.0.sh gridss_225.sh
qsub -q big gridss_225.sh

#
# ## Did not look for single nucleotide variants

# ############
# ## analysis moves from command line to R
# RSCRIPTS=$TOOLDIR/maldrugR
