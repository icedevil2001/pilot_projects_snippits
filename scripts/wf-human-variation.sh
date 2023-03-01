
GITREPO_DIR=/data/git_repo
REPO='https://github.com/epi2me-labs/wf-human-variation.git'


mkdir -p $GITREPO_DIR
cd $GITREPO_DIR

git clone $REPO --depth 1 --brach 1.2.0
