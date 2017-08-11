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
  # fastqc output
  fastqc-zips:
    type: File[]
    outputSource: fastqc/zippedFile
  fastqc-reports:
    type: File[]
    outputSource: fastqc/report

steps:

  #
  # Quality inspection of raw data:
  #
  fastqc:
    run: ../tools/src/tools/fastqc.cwl

    in:
      fastq: [read1, read2]

      outdir:
        default: '.'


    out: [zippedFile, report]
