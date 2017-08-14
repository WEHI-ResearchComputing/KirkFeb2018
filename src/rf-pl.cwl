#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

requirements:
- class: InlineJavascriptRequirement
  expressionLib:
  - var num_threads = function() { return 4; };
  - var tool_location = function() { return "tools/src/tools/"; };
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: MultipleInputFeatureRequirement
- $import: ../tools/src/tools/envvar-global.yml

inputs:
  read1: File
  read2: File

outputs:
  # # fastqc output
  # fastqc-zips:
  #   type: File[]
  #   outputSource: fastqc/zippedFile
  # fastqc-reports:
  #   type: File[]
  #   outputSource: fastqc/report
  # alignment
  align-sam:
    type: File
    outputSource: align/aligned-file
  # convert
  sorted:
    type: File
    streamable: true
    outputSource: convert/output
  # sort and compress
  compressed:
    type: File
    outputSource: sort/sorted
  # Index human bam
  indexed:
    type: File
    outputSource: index/index
  # Dedup
  deduped-output:
    type: File
    outputSource: dedup/markDups_output
  deduped-metrics:
    type: File
    outputSource: dedup/markDups_metrics
  index-dedup-out:
    type: File
    outputSource: index-dedup/index
  # Insert Metrics
  # insert-metrics-output:
  #   type: File
  #   outputSource: dedup/markDups_output
  # insert-metrics-histogram:
  #   type: File
  #   outputSource: dedup/markDups_metrics
  # index-dedup-out:
  #   type: File
  #   outputSource: index-dedup/index
  # insert-metrics-output:
  #   type: File
  #   outputSource: insert-metrics/output
  # insert-metrics-histogram:
  #   type: File
  #   outputSource: insert-metrics/histogram
  # Coverage files
  # intersect-genic-out:
  #   type: File
  #   outputSource: intersect-genic/intersect
  # intersect-nongenic-out:
  #   type: File
  #   outputSource: intersect-nongenic/intersect
  igvtools-out:
    type: File
    outputSource: igvtools/output

steps:

  # #
  # # Quality inspection of raw data:
  # #
  # fastqc:
  #   run: ../tools/src/tools/fastqc.cwl

  #   in:
  #     fastq: [read1, read2]

  #     outdir:
  #       default: '.'


  #   out: [zippedFile, report]

  #
  # Alignment to ref v29 with bowtie2
  #
  align:
    run: ../tools/src/tools/bowtie2.cwl

    in:
      samout:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '.sam'
          }

      threads:
        valueFrom: $( num_threads() )

      one: read1

      two: read2

      bt2-idx:
        default: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome

      sensitive-local:
        default: true

      rg:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return 'SM:' + fn + ' PL:ILLUMINA';
          }

      rg-id:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn;
          }

    out: [aligned-file]


  #
  # convert to bam
  #
  convert:
    run: ../tools/src/tools/samtools-view.cwl

    in:
      input:
        align/aligned-file
      output_name:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '.bam'
          }
      threads:
        valueFrom: ${ return num_threads(); }

    out: [output]

  #
  # sort and compress
  #
  sort:
    run: ../tools/src/tools/samtools-sort.cwl

    in:
      input:
        source: convert/output
      output_name:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '.sorted.bam'
          }
      threads:
        valueFrom: ${ return num_threads(); }

    out: [sorted]

  #
  # index bam
  #
  index:
    run: ../tools/src/tools/samtools-index.cwl

    in:
      input:
        source: sort/sorted

    out: [index]

#
# Remove duplicate reads
#
  dedup:
    run: ../tools/src/tools/picard-MarkDuplicates.cwl

    in:
      inputFileName_markDups: sort/sorted

      outputFileName_markDups:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '_nodup.bam'
          }

      metricsFile:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '_duplic.metrics'
          }

      removeDuplicates:
        default: true

    out: [markDups_output, markDups_metrics]

  #
  # index duplicates
  #
  index-dedup:
    run: ../tools/src/tools/samtools-index.cwl

    in:
      input:
        source: dedup/markDups_output

    out: [index]


# #
# # Collect insert-size, aka fragment-size, statistics
# #
#   insert-metrics:
#     run: ../tools/src/tools/picard-CollectInsertSizeMetrics.cwl

#     in:
#       INPUT: dedup/markDups_output

#       OUTPUT:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.insert-metrics.txt'
#           }

#       HISTOGRAM_FILE:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.insert-metrics.pdf'
#           }

#       removeDuplicates:
#         default: true

#     out: [output, histogram]

#   #
#   # Inspect coverage and gene bias:-
#   # bedtools genomecov -d -split -ibam 225-${fn}_nodup.bam
#   #
#   coverage:
#     run: ../tools/src/tools/bedtools-genomecov.cwl

#     in:
#       input:
#         source: dedup/markDups_output
#         valueFrom: >
#           ${
#               self.format = "http://edamontology.org/format_2572";
#               return self;
#           }

#       genomecoverageout:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.genomecov.out'
#           }

#       depth:
#         valueFrom: '-d'

#       split:
#         default: true

#     out: [genomecoverage]

#   #
#   # Summarize genomecov output
#   #
#   summarize-genomecov:
#     run: ../tools/src/tools/awk.cwl

#     in:
#       infile: coverage/genomecoverage

#       program:
#         valueFrom: >
#           $( '{total += $3; count +=1; sumsq += $3*$3}; END {print "mean cov is", total / count, ". Var of cov is", (sumsq - total^2/count)/(count-1)}' )

#       outputFileName:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.genomecov.summary.txt'
#           }

#     out: [output]

# #
# # bedtools intersect genic
# #
#   intersect-genic:
#     run: ../tools/src/tools/bedtools-intersect.cwl

#     in:
#       inputA:
#         source: dedup/markDups_output
#         valueFrom: >
#           ${
#               self.format = "http://edamontology.org/format_2572";
#               return self;
#           }

#       inputB:
#          default:
#            class: File
#            location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff

#       split:
#         valueFrom: $( true )

#       intersectout:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.intersect.genic.bam'
#           }

#     out: [intersect]


# #
# # bedtools intersect non-genic
# #
#   intersect-nongenic:
#     run: ../tools/src/tools/bedtools-intersect.cwl

#     in:
#       inputA:
#         source: dedup/markDups_output
#         valueFrom: >
#           ${
#               self.format = "http://edamontology.org/format_2572";
#               return self;
#           }

#       inputB:
#          default:
#            class: File
#            location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff

#       reportNoOverlaps:
#         valueFrom: $( true )

#       intersectout:
#         source: read1
#         valueFrom: >
#           ${
#               var fn = self.nameroot;
#               fn = fn.substring(0,fn.length-9);
#               return fn + '.intersect.nongenic.bam'
#           }

#     out: [intersect]

  # #
  # # Inspect coverage of genic intersection
  # #
  # coverage-genic:
  #   run: ../tools/src/tools/bedtools-genomecov.cwl

  #   in:
  #     input:
  #       source: intersect-genic/intersect
  #       valueFrom: >
  #         ${
  #             self.format = "http://edamontology.org/format_2572";
  #             return self;
  #         }

  #     genomecoverageout:
  #       source: read1
  #       valueFrom: >
  #         ${
  #             var fn = self.nameroot;
  #             fn = fn.substring(0,fn.length-9);
  #             return fn + '.genic.genomecov.out'
  #         }

  #     depth:
  #       valueFrom: '-d'

  #     split:
  #       default: true

  #   out: [genomecoverage]

  # #
  # # Summarize coverage output
  # #
  # summarize-genic-genomecov:
  #   run: ../tools/src/tools/awk.cwl

  #   in:
  #     infile: coverage-genic/genomecoverage

  #     program:
  #       valueFrom: >
  #         $( '{total += $3; count +=1}; END {print "total of all reads at genic bases", total, ", mean cov is", total / 13979861}' )

  #     outputFileName:
  #       source: read1
  #       valueFrom: >
  #         ${
  #             var fn = self.nameroot;
  #             fn = fn.substring(0,fn.length-9);
  #             return fn + '.genic.genomecov.summary.txt'
  #         }

  #   out: [output]


  # #
  # # Inspect coverage of nongenic intersection
  # #
  # coverage-nongenic:
  #   run: ../tools/src/tools/bedtools-genomecov.cwl

  #   in:
  #     input:
  #       source: intersect-nongenic/intersect
  #       valueFrom: >
  #         ${
  #             self.format = "http://edamontology.org/format_2572";
  #             return self;
  #         }

  #     genomecoverageout:
  #       source: read1
  #       valueFrom: >
  #         ${
  #             var fn = self.nameroot;
  #             fn = fn.substring(0,fn.length-9);
  #             return fn + '.nongenic.genomecov.out'
  #         }

  #     depth:
  #       valueFrom: '-d'

  #     split:
  #       default: true

  #   out: [genomecoverage]

  # #
  # # Summarize coverage output
  # #
  # summarize-nongenic-genomecov:
  #   run: ../tools/src/tools/awk.cwl

  #   in:
  #     infile: coverage-nongenic/genomecoverage

  #     program:
  #       valueFrom: >
  #         $( '{total += $3; count +=1}; END {print "total of all reads at nongene bases", total, ", mean cov is", total / 13979861}' )

  #     outputFileName:
  #       source: read1
  #       valueFrom: >
  #         ${
  #             var fn = self.nameroot;
  #             fn = fn.substring(0,fn.length-9);
  #             return fn + '.nongenic.genomecov.summary.txt'
  #         }

  #   out: [output]

  #
  # Looking at bams in IGV is memory-hungry, and could be replaced by using tdf-format
  # coverage files. 3D7-merge-B3_S1-C5_S2.bam done at command line.
  # Default window size is 25bp
  #
  igvtools:
    run: ../tools/src/tools/igvtools-count.cwl

    in:
      inputFile: dedup/markDups_output

      outputFileName:
        source: read1
        valueFrom: >
          ${
              var fn = self.nameroot;
              fn = fn.substring(0,fn.length-9);
              return fn + '.tdf';
          }

      genome:
         default:
           class: File
           location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta

    out: [output]


