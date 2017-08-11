## Coverage and gene bias.
## Copied and modified from coverage.sh in drug_resistance/analysis_tools
## Sum of lengths of genes=13979861  was found by 
## drug_resistance/analysis_tools/maldrugR/read_genesizesfrom_gff.R from
## PlasmoDB-29_Pfalciparum3D7.gff
## Clove needs variance

PAPDIR=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects
BASEDIR=$PAPDIR/malaria/cowman_lab/drug_resistance
ALIGNDIR=$BASEDIR/drug225/alignment
REFDIR=$PAPDIR/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7

TOTGENELENGTH=13979861
cd $ALIGNDIR
for fn in '1-B4_S1' '2-G11_S2' '3-D8_S3' '3-F5_S4'
do

   bedtools genomecov -d -split -ibam 225-${fn}_nodup.bam  |  \
   awk '{total += $3; count +=1; sumsq += $3*$3}; \
      END {print "mean cov of '$fn' is", total / count,  \
          ". Var of cov is", (sumsq - total^2/count)/(count-1)}' 

   bedtools intersect -split -a 225-${fn}_nodup.bam \
	  -b $REFDIR/PlasmoDB-29_Pfalciparum3D7.gff > ${fn}_genic.bam
   bedtools intersect -v -a 225-${fn}_nodup.bam \
	  -b $REFDIR/PlasmoDB-29_Pfalciparum3D7.gff > ${fn}_nongenic.bam
	 
	bedtools genomecov -d -ibam ${fn}_genic.bam | awk '{total += $3; count +=1}; \
	  END {print "total of all '$fn' reads at genic bases", total, \
	  ", mean cov is", total / '$TOTGENELENGTH'}'
   bedtools genomecov -d -ibam ${fn}_nongenic.bam | awk '{total += $3; count +=1}; \
	  END {print "total of all '$fn' reads at nongene bases", total, \
	  ", mean cov is", total / (count - '$TOTGENELENGTH')}'
	 
   rm ${fn}_genic.bam ${fn}_nongenic.bam
	 
done
