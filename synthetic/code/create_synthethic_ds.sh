#!/bin/bash

# small bash script to create a synthethic BIDS data set

# defines where the BIDS data set will be created
code_dir=$( dirname $0 )
raw_dir=$( dirname $code_dir )

subject_list='01 02 03 04 05'
session_list='01'

create_raw_beh() {

    target_dir=$1
    subject=$2
    ses=$3

    suffix='_beh'
    task_name='stroop'

    this_dir=${target_dir}/sub-${subject}/ses-${ses}/beh

    mkdir -p ${this_dir}

    filename=${this_dir}/sub-${subject}_ses-${ses}_task-${task_name}${suffix}.tsv
    echo -e "trial\tresponse\treaction_time\tstim_file" >${filename}
    echo -e "congruent\tred\t1.435\timages/word-red_color-red.jpg" >>${filename}
    echo -e "incongruent\tred\t1.739\timages/word-red_color-blue.jpg" >>${filename}
}

# RAW DATASET
for subject in ${subject_list}; do
    for ses in ${session_list}; do
        create_raw_beh ${raw_dir} ${subject} ${ses}
    done

done

mkdir -p ${raw_dir}/stimuli/images
touch ${raw_dir}/stimuli/images/word-red_color-red.jpg
touch ${raw_dir}/stimuli/images/word-red_color-blue.jpg
