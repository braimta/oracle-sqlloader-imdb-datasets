#!/bin/bash 
# 
# 
# To delete all downladed files, logs and create files...
# > rm -rfv logs/* data/* ./*.ctl ./load-all.log
# 
# To call this script
# > ./load-all.sh USERNAME/"PASSWORD"@host:port/service |& tee load-all.log
# 

set -x


if [ $# -ne 1 ]; then
  echo "please provide how to connect to db!"
  exit 1;
fi

for p in sqlplus sqlldr; do 
  if ! [ -x "$(command -v $p)" ]; then
    echo "$p is not installed ?" >&2
    exit 2
  fi
done;

PROCESSING_FOLDER_NAME="imdb-$(date +%Y-%m-%d-%H-%M)"
mkdir -p "${PROCESSING_FOLDER_NAME}"

#
# download imdb datasets
IMDB_URL=https://datasets.imdbws.com
IMDB_FILES=(name.basics.tsv.gz  \
            title.akas.tsv.gz \
            title.basics.tsv.gz \
            title.crew.tsv.gz \
            title.episode.tsv.gz \
            title.principals.tsv.gz \
            title.ratings.tsv.gz
      )

# target directory (where to download the files)
export DOWNLOAD_DIR="${PROCESSING_FOLDER_NAME}/data"
export LOGS_DIR="${PROCESSING_FOLDER_NAME}/logs"


# loop through the array to download the file to the target directory.
for f in ${IMDB_FILES[@]}; do
  curl --create-dirs -O --output-dir $DOWNLOAD_DIR -z "DOWNLOAD_DIR/$f"  "$IMDB_URL/$f"
done


# # when downloaded, some files are zipped; unzip them.
gunzip --force --keep $DOWNLOAD_DIR/*.gz


# # then generate the control files for sql loader from the templates
mkdir -p "${PROCESSING_FOLDER_NAME}/sqlldr"
for f in $(find templates -type f -name "*.ctl"); do 
  envsubst < $f > "$PROCESSING_FOLDER_NAME/sqlldr/$(basename $f)";
done


#  # import the data
mkdir -p "${PROCESSING_FOLDER_NAME}/logs"
for f in $(find "${PROCESSING_FOLDER_NAME}/sqlldr" -maxdepth 1 -type f -name "*.ctl" | sort); do 
  sqlldr "$1" control="$f" log="${PROCESSING_FOLDER_NAME}/logs/$(basename $f).log"
done

# # run some scripts...
# exit | sqlplus "$1" << EOF 
# set echo on
# set timing on
# @${PROCESSING_FOLDER_NAME}/sql/all.sql
# EOF
