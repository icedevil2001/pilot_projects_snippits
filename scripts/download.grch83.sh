

# which reference
## https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use 

OUTPUTDIR=/data/reference/
_URL="ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz"
mkdir -p $OUTPUTDIR

REF_GZ=$OUTPUTDIR/$(basename $_URL)
REF=${REF_GZ%.gz}

if [[ -f $REF ]]
then
    echo "SKIPPED: Reference genome exists"
else
    echo "Download reference genome  $(basename $_URL)"
    wget --directory-prefix $OUTPUTDIR $_URL
    
    echo "Extracting gzip file"
    gzip -dc $REF_GZ > $REF

    echo "Index reference genome"
    samtools faidx $REF

    echo "Delete gzip file"
    rm $REF_GZ
fi