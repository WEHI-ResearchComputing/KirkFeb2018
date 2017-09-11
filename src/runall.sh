#!/bin/bash

#
# Do _not_ submit this to the batch system! It runs on the head node and controls submission
# of work to the batch system. It disconnects from command line and output goes to the log
# directory.
#

WORK_DIR=/stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/for-jocelyn
RESULTS_DIR=${WORK_DIR}/results
CWL_DIR=${WORK_DIR}/resistant-falciparum/src
LOG_DIR=${WORK_DIR}/logs
WEHI_PIPELINE=${WORK_DIR}/wehi-pipeline/src

cd $RESULTS_DIR

. ../toil-env/bin/activate

DRMAA_LIBRARY_PATH=/stornext/System/data/apps/pbs-drmaa/pbs-drmaa-1.0.19/lib/libdrmaa.so
export PYTHONPATH=${WEHI_PIPELINE}

fn=`date +%Y_%m_%d_%H_%M`

python ${WORK_DIR}/cwlwehi.py \
    --logLevel DEBUG \
    --batchSystem drmaa \
    --jobQueue static \
    --jobNamePrefix rfx \
    --jobStore ${fn}.wf \
    ${CWL_DIR}/rf-outer.cwl ${WORK_DIR}/inp.yml \
    &>> ${LOG_DIR}/${fn}.toil.log \
& disown
