#! /bin/bash

BAM=$1
REF=$2
SAMPLE_NAME=$3

MODEL_DIR="/data/models/"
MODEL=${MODEL_DIR}/r1041_e82_400bps_sup_v400_model
MODEL_URL="https://nanoporetech.box.com/shared/static/8yy7k68l8y22ejbp9fehl9ixpbroj5m9.tgz"

OUTPUT=/data/results/${SAMPLE_NAME}
WORKINGDIR=/data/temp/nextflow-workflow/${SAMPLE_NAME}

mkdir -p $OUTUT
mkdir -p $WORKINGDIR

if [[ -e $MDOEL ]]
then
    echo "Cair model: " $MODEL
else
    mkdir -p "/data/model"
    wget -p $MODEL_DIR  $MODEL_URL
    tar xvf $MODEL_DIR/$(basename $url)
fi


nextflow run /data/git_repo/wf-human-variation \
    -w /data/temp/nextflow-workflow/${SAMPLE_NAME} \
    -profile standard \
    -resume \
    --snp --sv --methyl --cnv \
    --bam $BAM \
    --ref $REF \
    --threads 20 \
    --sample_name $SAMPLE_NAME \
    --sv_types "INS,DEL,DUP,BND,INV" \
    --max_sv_length 1000000 \
    --clair3_model_path $MODEL \
    --out_dir $OUTPUT
