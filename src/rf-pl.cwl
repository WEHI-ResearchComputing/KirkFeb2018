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
              fn = fn.substring(0,fn.length-6);
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
              fn = fn.substring(0,fn.length-6);
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
              fn = fn.substring(0,fn.length-6);
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

