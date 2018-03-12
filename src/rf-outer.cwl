#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

requirements:
- class: InlineJavascriptRequirement
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
  s1-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/0A_S1_R1.fastq.gz
  s1-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/0A_S1_R2.fastq.gz
  s2-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/719F_S2_R1.fastq.gz
  s2-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/719F_S2_R2.fastq.gz
  s3-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/HLR4_S3_R1.fastq.gz
  s3-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/HLR4_S3_R2.fastq.gz
  s4-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/PAR_S4_R1.fastq.gz
  s4-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/PAR_S4_R2.fastq.gz
  s5-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/SPIR_S5_R1.fastq.gz
  s5-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/SPIR_S5_R2.fastq.gz
  s7-reads1:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/HLR15_S7_R1.fastq.gz
  s7-reads2:
    type: File
    default:
      class: File
      path: /stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/KirkFeb2018/sequence_data/HLR15_S7_R2.fastq.gz

  reference:
    type: File
    default:
      class: File
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta
      secondaryFiles:
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.fai
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.fai
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.amb
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.amb
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.ann
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.ann
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.bwt
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.bwt
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.pac
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.pac
        - class: File
          path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.sa
          location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.fasta.sa
  gff:
    type: File
    default:
      class: File
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.38.gff3
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/plasmodium_falciparum_dd2/Plasmodium_falciparum_dd2.ASM14979v1.38.gff3

  # reference:
  #   type: File
  #   default:
  #     class: File
  #     path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta
  #     location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta
  #     secondaryFiles:
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.amb
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.amb
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.ann
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.ann
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.bwt
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.bwt
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.fai
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.fai
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.pac
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.pac
  #       - class: File
  #         path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.sa
  #         location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7_Genome.fasta.sa
  # gff:
  #   type: File
  #   default:
  #     class: File
  #     path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff
  #     location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/PlasmoDB-29_Pfalciparum3D7/PlasmoDB-29_Pfalciparum3D7.gff

  blacklist:
    type: File
    default:
      class: File
      location: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/12.0/CentromereTelomereRegions.bed
      path: /wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/plasmodium/12.0/CentromereTelomereRegions.bed

outputs:

  # fastqc output
  s1-fastqc-zips:
    type: File[]
    outputSource: all-s1/fastqc-zips
  s1-fastqc-reports:
    type: File[]
    outputSource: all-s1/fastqc-reports
  # Alignment output
  s1-align-sam:
    type: File
    outputSource: all-s1/align-sam
  s1-align-stats:
    type: File
    outputSource: all-s1/align-stats
  # convert
  s1-sorted:
    type: File
    streamable: true
    outputSource: all-s1/sorted
  # sort and compress
  s1-compressed:
    type: File
    outputSource: all-s1/compressed
  # Index human bam
  s1-indexed:
    type: File
    outputSource: all-s1/indexed
  # Dedup
  s1-deduped-output:
    type: File
    outputSource: all-s1/deduped-output
  s1-deduped-metrics:
    type: File
    outputSource: all-s1/deduped-metrics
  s1-index-dedup-out:
    type: File
    outputSource: all-s1/index-dedup-out
  # Insert Metrics
  s1-insert-metrics-output:
    type: File
    outputSource: all-s1/insert-metrics-output
  s1-insert-metrics-histogram:
    type: File
    outputSource: all-s1/insert-metrics-histogram
  # Coverage files
  s1-summarize-genomecov-out:
    type: File
    outputSource: all-s1/summarize-genomecov-out
  s1-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s1/summarize-genic-genomecov-out
  s1-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s1/summarize-nongenic-genomecov-out
  # igvtools
  s1-igvtools-out:
    type: File
    outputSource: all-s1/igvtools-out


  # fastqc output
  s2-fastqc-zips:
    type: File[]
    outputSource: all-s2/fastqc-zips
  s2-fastqc-reports:
    type: File[]
    outputSource: all-s2/fastqc-reports
  # Alignment output
  s2-align-sam:
    type: File
    outputSource: all-s2/align-sam
  s2-align-stats:
    type: File
    outputSource: all-s2/align-stats
  # convert
  s2-sorted:
    type: File
    streamable: true
    outputSource: all-s2/sorted
  # sort and compress
  s2-compressed:
    type: File
    outputSource: all-s2/compressed
  # Index human bam
  s2-indexed:
    type: File
    outputSource: all-s2/indexed
  # Dedup
  s2-deduped-output:
    type: File
    outputSource: all-s2/deduped-output
  s2-deduped-metrics:
    type: File
    outputSource: all-s2/deduped-metrics
  s2-index-dedup-out:
    type: File
    outputSource: all-s2/index-dedup-out
  # Insert Metrics
  s2-insert-metrics-output:
    type: File
    outputSource: all-s2/insert-metrics-output
  s2-insert-metrics-histogram:
    type: File
    outputSource: all-s2/insert-metrics-histogram
  # Coverage files
  s2-summarize-genomecov-out:
    type: File
    outputSource: all-s2/summarize-genomecov-out
  s2-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s2/summarize-genic-genomecov-out
  s2-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s2/summarize-nongenic-genomecov-out
  # igvtools
  s2-igvtools-out:
    type: File
    outputSource: all-s2/igvtools-out

  # fastqc output
  s3-fastqc-zips:
    type: File[]
    outputSource: all-s3/fastqc-zips
  s3-fastqc-reports:
    type: File[]
    outputSource: all-s3/fastqc-reports
  # Alignment output
  s3-align-sam:
    type: File
    outputSource: all-s3/align-sam
  s3-align-stats:
    type: File
    outputSource: all-s3/align-stats
  # convert
  s3-sorted:
    type: File
    streamable: true
    outputSource: all-s3/sorted
  # sort and compress
  s3-compressed:
    type: File
    outputSource: all-s3/compressed
  # Index human bam
  s3-indexed:
    type: File
    outputSource: all-s3/indexed
  # Dedup
  s3-deduped-output:
    type: File
    outputSource: all-s3/deduped-output
  s3-deduped-metrics:
    type: File
    outputSource: all-s3/deduped-metrics
  s3-index-dedup-out:
    type: File
    outputSource: all-s3/index-dedup-out
  # Insert Metrics
  s3-insert-metrics-output:
    type: File
    outputSource: all-s3/insert-metrics-output
  s3-insert-metrics-histogram:
    type: File
    outputSource: all-s3/insert-metrics-histogram
  # Coverage files
  s3-summarize-genomecov-out:
    type: File
    outputSource: all-s3/summarize-genomecov-out
  s3-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s3/summarize-genic-genomecov-out
  s3-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s3/summarize-nongenic-genomecov-out
  # igvtools
  s3-igvtools-out:
    type: File
    outputSource: all-s3/igvtools-out

  # fastqc output
  s4-fastqc-zips:
    type: File[]
    outputSource: all-s4/fastqc-zips
  s4-fastqc-reports:
    type: File[]
    outputSource: all-s4/fastqc-reports
  # Alignment output
  s4-align-sam:
    type: File
    outputSource: all-s4/align-sam
  s4-align-stats:
    type: File
    outputSource: all-s4/align-stats
  # convert
  s4-sorted:
    type: File
    streamable: true
    outputSource: all-s4/sorted
  # sort and compress
  s4-compressed:
    type: File
    outputSource: all-s4/compressed
  # Index human bam
  s4-indexed:
    type: File
    outputSource: all-s4/indexed
  # Dedup
  s4-deduped-output:
    type: File
    outputSource: all-s4/deduped-output
  s4-deduped-metrics:
    type: File
    outputSource: all-s4/deduped-metrics
  s4-index-dedup-out:
    type: File
    outputSource: all-s4/index-dedup-out
  # Insert Metrics
  s4-insert-metrics-output:
    type: File
    outputSource: all-s4/insert-metrics-output
  s4-insert-metrics-histogram:
    type: File
    outputSource: all-s4/insert-metrics-histogram
  # Coverage files
  s4-summarize-genomecov-out:
    type: File
    outputSource: all-s4/summarize-genomecov-out
  s4-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s4/summarize-genic-genomecov-out
  s4-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s4/summarize-nongenic-genomecov-out
  # igvtools
  s4-igvtools-out:
    type: File
    outputSource: all-s4/igvtools-out

  # fastqc output
  s5-fastqc-zips:
    type: File[]
    outputSource: all-s5/fastqc-zips
  s5-fastqc-reports:
    type: File[]
    outputSource: all-s5/fastqc-reports
  # Alignment output
  s5-align-sam:
    type: File
    outputSource: all-s5/align-sam
  s5-align-stats:
    type: File
    outputSource: all-s5/align-stats
  # convert
  s5-sorted:
    type: File
    streamable: true
    outputSource: all-s5/sorted
  # sort and compress
  s5-compressed:
    type: File
    outputSource: all-s5/compressed
  # Index human bam
  s5-indexed:
    type: File
    outputSource: all-s5/indexed
  # Dedup
  s5-deduped-output:
    type: File
    outputSource: all-s5/deduped-output
  s5-deduped-metrics:
    type: File
    outputSource: all-s5/deduped-metrics
  s5-index-dedup-out:
    type: File
    outputSource: all-s5/index-dedup-out
  # Insert Metrics
  s5-insert-metrics-output:
    type: File
    outputSource: all-s5/insert-metrics-output
  s5-insert-metrics-histogram:
    type: File
    outputSource: all-s5/insert-metrics-histogram
  # Coverage files
  s5-summarize-genomecov-out:
    type: File
    outputSource: all-s5/summarize-genomecov-out
  s5-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s5/summarize-genic-genomecov-out
  s5-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s5/summarize-nongenic-genomecov-out
  # igvtools
  s5-igvtools-out:
    type: File
    outputSource: all-s5/igvtools-out

  # fastqc output
  s7-fastqc-zips:
    type: File[]
    outputSource: all-s7/fastqc-zips
  s7-fastqc-reports:
    type: File[]
    outputSource: all-s7/fastqc-reports
  # Alignment output
  s7-align-sam:
    type: File
    outputSource: all-s7/align-sam
  s7-align-stats:
    type: File
    outputSource: all-s7/align-stats
  # convert
  s7-sorted:
    type: File
    streamable: true
    outputSource: all-s7/sorted
  # sort and compress
  s7-compressed:
    type: File
    outputSource: all-s7/compressed
  # Index human bam
  s7-indexed:
    type: File
    outputSource: all-s7/indexed
  # Dedup
  s7-deduped-output:
    type: File
    outputSource: all-s7/deduped-output
  s7-deduped-metrics:
    type: File
    outputSource: all-s7/deduped-metrics
  s7-index-dedup-out:
    type: File
    outputSource: all-s7/index-dedup-out
  # Insert Metrics
  s7-insert-metrics-output:
    type: File
    outputSource: all-s7/insert-metrics-output
  s7-insert-metrics-histogram:
    type: File
    outputSource: all-s7/insert-metrics-histogram
  # Coverage files
  s7-summarize-genomecov-out:
    type: File
    outputSource: all-s7/summarize-genomecov-out
  s7-summarize-genic-genomecov-out:
    type: File
    outputSource: all-s7/summarize-genic-genomecov-out
  s7-summarize-nongenic-genomecov-out:
    type: File
    outputSource: all-s7/summarize-nongenic-genomecov-out
  # igvtools
  s7-igvtools-out:
    type: File
    outputSource: all-s7/igvtools-out


    # gridss
  gridss-s1-s2-bam:
    type: File
    outputSource: gridss-s1-s2/bam
  gridss-s1-s2-vcf:
    type: File
    outputSource: gridss-s1-s2/vcf
  gridss-s1-s2-bam-dir:
    type: Directory
    outputSource: gridss-s1-s2/bam_working

  gridss-s4-s5-bam:
    type: File
    outputSource: gridss-s4-s5/bam
  gridss-s4-s5-vcf:
    type: File
    outputSource: gridss-s4-s5/vcf
  gridss-s4-s5-bam-dir:
    type: Directory
    outputSource: gridss-s4-s5/bam_working

  gridss-s5-s3-bam:
    type: File
    outputSource: gridss-s5-s3/bam
  gridss-s5-s3-vcf:
    type: File
    outputSource: gridss-s5-s3/vcf
  gridss-s5-s3-bam-dir:
    type: Directory
    outputSource: gridss-s5-s3/bam_working

  gridss-s5-s7-bam:
    type: File
    outputSource: gridss-s5-s7/bam
  gridss-s5-s7-vcf:
    type: File
    outputSource: gridss-s5-s7/vcf
  gridss-s5-s7-bam-dir:
    type: Directory
    outputSource: gridss-s5-s7/bam_working


steps:

  all-s1:
    run: rf-pl.cwl

    in:
      read1: s1-reads1
      read2: s1-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  all-s2:
    run: rf-pl.cwl

    in:
      read1: s2-reads1
      read2: s2-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  all-s3:
    run: rf-pl.cwl

    in:
      read1: s3-reads1
      read2: s3-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  all-s4:
    run: rf-pl.cwl

    in:
      read1: s4-reads1
      read2: s4-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  all-s5:
    run: rf-pl.cwl

    in:
      read1: s5-reads1
      read2: s5-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  all-s7:
    run: rf-pl.cwl

    in:
      read1: s7-reads1
      read2: s7-reads2
      reference: reference
      gff: gff

    out: [
        fastqc-zips,
        fastqc-reports,
        align-sam,
        align-stats,
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

  #
  # GRIDSS
  #
  gridss-s1-s2:
    run: rf-gridss.cwl

    in:
      main-input: all-s2/deduped-output
      parent-merge: all-s1/deduped-output
      reference: reference
      blacklist: blacklist

    out: [vcf, bam, bam_working]

  gridss-s4-s5:
    run: rf-gridss.cwl

    in:
      main-input: all-s5/deduped-output
      parent-merge: all-s4/deduped-output
      reference: reference
      blacklist: blacklist

    out: [vcf, bam, bam_working]


  gridss-s5-s3:
    run: rf-gridss.cwl

    in:
      main-input: all-s3/deduped-output
      parent-merge: all-s5/deduped-output
      reference: reference
      blacklist: blacklist

    out: [vcf, bam, bam_working]


  gridss-s5-s7:
    run: rf-gridss.cwl

    in:
      main-input: all-s7/deduped-output
      parent-merge: all-s5/deduped-output
      reference: reference
      blacklist: blacklist

    out: [vcf, bam, bam_working]


