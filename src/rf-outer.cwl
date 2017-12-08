#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

requirements:
- class: InlineJavascriptRequirement
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
  child-reads1: File[]
  child-reads2: File[]
  parent-reads1: File[]
  parent-reads2: File[]
  alignment:
      type: File
      default:
        class: File
        path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/drug754/alignment/3D7-merge-B3_S1-C5_S2.bam
        location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/drug754/alignment/3D7-merge-B3_S1-C5_S2.bam
  reference:
    type: File
    default:
      class: File
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta
      secondaryFiles:
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.amb
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.amb
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.ann
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.ann
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.bwt
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.bwt
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.fai
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.fai
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.pac
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.pac
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.sa
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.sa
  gff:
    type: File
    default:
      class: File
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff
  blacklist:
    type: File
    default:
      class: File
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/12.0/CentromereTelomereRegions.bed
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/12.0/CentromereTelomereRegions.bed

outputs:
  #
  # Parent
  #
  # fastqc output
  parent-fastqc-zips:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: all-parents/fastqc-zips
  parent-fastqc-reports:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: all-parents/fastqc-reports
  # convert
  parent-sorted:
    type: File[]
    streamable: true
    outputSource: all-parents/sorted
  # sort and compress
  parent-compressed:
    type: File[]
    outputSource: all-parents/compressed
  # Index human bam
  parent-indexed:
    type: File[]
    outputSource: all-parents/indexed
  # Dedup
  parent-deduped-output:
    type: File[]
    outputSource: all-parents/deduped-output
  parent-deduped-metrics:
    type:
      type: array
      items:
        - "null"
        - File
    outputSource: all-parents/deduped-metrics
  parent-index-dedup-out:
    type: File[]
    outputSource: all-parents/index-dedup-out
  # Insert Metrics
  parent-insert-metrics-output:
    type:
      type: array
      items:
        - "null"
        - File
    outputSource: all-parents/insert-metrics-output
  parent-insert-metrics-histogram:
    type: File[]
    outputSource: all-parents/insert-metrics-histogram
  # Coverage files
  parent-summarize-genomecov-out:
    type: File[]
    outputSource: all-parents/summarize-genomecov-out
  parent-summarize-genic-genomecov-out:
    type: File[]
    outputSource: all-parents/summarize-genic-genomecov-out
  parent-summarize-nongenic-genomecov-out:
    type: File[]
    outputSource: all-parents/summarize-nongenic-genomecov-out
  # igvtools
  parent-igvtools-out:
    type: File[]
    outputSource: all-parents/igvtools-out

  #
  # Child outputs
  #
  # fastqc output
  child-fastqc-zips:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: all-children/fastqc-zips
  child-fastqc-reports:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: all-children/fastqc-reports
  # convert
  child-sorted:
    type: File[]
    streamable: true
    outputSource: all-children/sorted
  # sort and compress
  child-compressed:
    type: File[]
    outputSource: all-children/compressed
  # Index human bam
  child-indexed:
    type: File[]
    outputSource: all-children/indexed
  # Dedup
  child-deduped-output:
    type: File[]
    outputSource: all-children/deduped-output
  child-deduped-metrics:
    type:
      type: array
      items:
        - "null"
        - File
    outputSource: all-children/deduped-metrics
  child-index-dedup-out:
    type: File[]
    outputSource: all-children/index-dedup-out
  # Insert Metrics
  child-insert-metrics-output:
    type:
      type: array
      items:
        - "null"
        - File
    outputSource: all-children/insert-metrics-output
  child-insert-metrics-histogram:
    type: File[]
    outputSource: all-children/insert-metrics-histogram
  # Coverage files
  child-summarize-genomecov-out:
    type: File[]
    outputSource: all-children/summarize-genomecov-out
  child-summarize-genic-genomecov-out:
    type: File[]
    outputSource: all-children/summarize-genic-genomecov-out
  child-summarize-nongenic-genomecov-out:
    type: File[]
    outputSource: all-children/summarize-nongenic-genomecov-out
  # igvtools
  child-igvtools-out:
    type: File[]
    outputSource: all-children/igvtools-out

  #
  # Merge parents
  #
  parent-merge:
    type: File
    outputSource: merge-parents/merge

  parent-merge-igvtools:
    type: File
    outputSource: merge-parents-igvtools/output

  parent-merge-index:
    type: File
    outputSource: merge-parent-index/index

    # gridss
  gridss-bam:
    type: File[]
    outputSource: gridss/bam
  gridss-vcf:
    type: File[]
    outputSource: gridss/vcf
  gridss-bam-dir:
    type: Directory[]
    outputSource: gridss/bam_working


steps:

  all-children:
    run: rf-pl.cwl

    scatter: [read1, read2]
    scatterMethod: dotproduct

    in:
      read1: child-reads1
      read2: child-reads2
      alignment: alignment
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        sorted,
        compressed,
        indexed,
        deduped-output,
        deduped-metrics,
        index-dedup-out,
        insert-metrics-output,
        insert-metrics-histogram,
        intersect-genic-out,
        intersect-nongenic-out,
        summarize-genomecov-out,
        summarize-genic-genomecov-out,
        summarize-nongenic-genomecov-out,
        igvtools-out
      ]

  all-parents:
    run: rf-pl.cwl

    scatter: [read1, read2]
    scatterMethod: dotproduct

    in:
      read1: parent-reads1
      read2: parent-reads2
      alignment: alignment
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        sorted,
        compressed,
        indexed,
        deduped-output,
        deduped-metrics,
        index-dedup-out,
        insert-metrics-output,
        insert-metrics-histogram,
        intersect-genic-out,
        intersect-nongenic-out,
        summarize-genomecov-out,
        summarize-genic-genomecov-out,
        summarize-nongenic-genomecov-out,
        igvtools-out
      ]

  merge-parents:
    run: ../tools/src/tools/samtools-merge.cwl

    in:
      input: all-parents/deduped-output
      outputFile:
        valueFrom: $('3D7-merge-B2_S1-F4_S4.bam')

    out: [merge]

  #
  # index bam
  #
  merge-parent-index:
    run: ../tools/src/tools/samtools-index.cwl

    in:
      input:
        source: merge-parents/merge

    out: [index]

  #
  # Looking at bams in IGV is memory-hungry, and could be replaced by using tdf-format
  # coverage files. 3D7-merge-B3_S1-C5_S2.bam done at command line.
  # Default window size is 25bp
  #
  merge-parents-igvtools:
    run: ../tools/src/tools/igvtools-count.cwl

    in:
      inputFile: merge-parents/merge

      outputFileName:
        source: parent-reads1
        valueFrom: $('3D7-merge-B2_S1-F4_S4.tdf')

      genome:
        source: reference

    out: [output]

  #
  # GRIDSS
  #
  gridss:
    run: rf-gridss.cwl

    scatter: [main-input]

    in:
      main-input: all-children/deduped-output
      parent-merge: merge-parents/merge
      reference: reference
      blacklist: blacklist

    out: [vcf, bam, bam_working]


