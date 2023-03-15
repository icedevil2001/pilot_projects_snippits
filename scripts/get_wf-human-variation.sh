
GITREPO_DIR=/data/git_repo3
REPO='https://github.com/epi2me-labs/wf-human-variation.git'

mkdir -p $GITREPO_DIR
cd $GITREPO_DIR

git clone --depth 1  $REPO --branch 'v1.3.0'
