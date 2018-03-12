#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

requirements:
- class: InlineJavascriptRequirement
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
  main-input: File
  parent-merge: File
  reference: File
  blacklist: File

outputs:
  bam:
    type: File
    outputSource: gridss/bam
  vcf:
    type: File
    outputSource: gridss/vcf
  vcf_working:
    type: Directory
    outputSource: gridss/vcf_working
  bam_working:
    type: Directory
    outputSource: gridss/bam_working


steps:

  gridss:
    run: ../tools/src/tools/gridss-callvariants.cwl
    requirements:
      ResourceRequirement:
        coresMin: 16
        ramMin: 64000

    in:
      INPUT:
        source: main-input
        valueFrom: >
          ${
              if ( self == null ) {
                return null;
              } else {
                return [self];
              }
          }
      INPUT2:
        source: parent-merge
        valueFrom: >
          ${
              if ( self == null ) {
                return null;
              } else {
                return [self];
              }
          }

      INPUT_LABEL:
        source: main-input
        valueFrom: >
          ${
              return [self.nameroot];
          }
      INPUT_LABEL2:
        source: parent-merge
        valueFrom: >
          ${
              return [self.nameroot];
          }

      REFERENCE_SEQUENCE: reference

      BLACKLIST: blacklist

      WORKER_THREADS:
        valueFrom: $( 16 )

      OUTPUT:
        source: main-input
        valueFrom: >
          ${
              return self.nameroot + '.gridss.assembly.vcf'
          }

      ASSEMBLY:
        source: main-input
        valueFrom: >
          ${
              return self.nameroot + '.gridss.assembly.bam'
          }

    out: [vcf, bam, vcf_working, bam_working]


