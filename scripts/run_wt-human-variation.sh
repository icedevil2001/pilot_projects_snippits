

BAM=$1


REF="/data/reference/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo $SCRIPT_DIR

if [[ ! -f $REF ]]
then
    echo "Download Reference"
    bash $SCRIPT_DIR/download.grch38.sh
fi 


# SAMPLE_NAME=$2
BAM_NAME=$(basename -- "$BAM")
SAMPLE_NAME=${BAM_NAME%.bam}

MODEL_DIR='/data/models/'
MODEL=${MODEL_DIR}/r1041_e82_400bps_sup_v400

OUTPUT=/data/results/${SAMPLE_NAME}
WORKINGDIR=/data/temp/nextflow-workflow/${SAMPLE_NAME}

mkdir -p $OUTPUT
mkdir -p $WORKINGDIR


## Download Clair model
if [[ -e $MODEL ]]
then
    echo "Clair model: " $MODEL
else
    echo "Download Clair model"
    mkdir -p $MODEL_DIR
    cd $MODEL_DIR

    MODEL_URL="https://nanoporetech.box.com/shared/static/8yy7k68l8y22ejbp9fehl9ixpbroj5m9.tgz"
    wget $MODEL_URL
    tar xvf $(basename -- "$MODEL_URL")
fi

echo $OUTPUT

    #--genome hg38 
# run Workflow
nextflow run /data/git_repo/wf-human-variation \
    -w /data/temp/nextflow-workflow/${SAMPLE_NAME} \
    -profile standard \
    -resume \
    --snp --sv --methyl \
    --bam $BAM \
    --ref $REF \
    --bin_size 10 \
    --sample_name $SAMPLE_NAME \
    --sv_types "INS,DEL,DUP,BND,INV" \
    --max_sv_length 1000000 \
    --clair3_model_path $MODEL \
    --out_dir $OUTPUT \
    --threads 20  
