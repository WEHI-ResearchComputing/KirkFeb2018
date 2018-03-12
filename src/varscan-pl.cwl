#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0

requirements:
- class: InlineJavascriptRequirement
  expressionLib:
  - var tool_location = function() { return "tools/src/tools/"; };
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: MultipleInputFeatureRequirement
- $import: ../tools/src/tools/envvar-global.yml

inputs:
  sorted-bam: File[]
  reference: File

outputs:
    # pileup
  mpileup-out:
    type: File[]
    outputSource: mpileup/output
 # varscan output
  varscan-out:
    type: File[]
    outputSource: varscan/output

steps:
  #
  # human pileup file
  #
  mpileup:
    run: ../tools/src/tools/samtools-mpileup.cwl

    scatter: [bamFiles]

    in:
      bamFiles:
        source: sorted-bam
        valueFrom: >
          ${
              if ( self == null ) {
                return null;
              } else {
                return [self];
              }
            }

      output_fn:
        source: sorted-bam
        valueFrom: >
          ${
            return self.nameroot + '.pileup'
          }

    out: [output]

  #
  # varscan human
  #
  varscan:
    run: ../tools/src/tools/varscan-mpileup2snp.cwl

    scatter: [input]

    in:
      input:
        source: mpileup/output

      output-vcf:
        valueFrom: >
          ${
            return true;
          }

    out: [output]
