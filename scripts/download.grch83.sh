

# which reference
## https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use 

OUTPUTDIR=/data/reference/

mkdir -p $OUTPUTDIR

wget --directory-prefix $OUTPUTDIR ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz

