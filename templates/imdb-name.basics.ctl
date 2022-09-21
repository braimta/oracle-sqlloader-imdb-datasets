OPTIONS
(
  -- 
  PARALLEL=FALSE,
  ROWS=65534,        -- 65534 = 64KB
  BINDSIZE=25000000, -- 1000000 = 1MB
  READSIZE=25000000,
  ERRORS=1000000,    --after 1 million errors, abort.
  SKIP=1
)
-- File are UTF-8 and for BOM check, I added it for clarification
LOAD DATA CHARACTERSET UTF8 BYTEORDERMARK CHECK
  INFILE '${DOWNLOAD_DIR}/name.basics.tsv'
  BADFILE '${LOGS_DIR}/name.basics-bad.txt'
  DISCARDFILE '${LOGS_DIR}/name.basics-discarded.txt'
  TRUNCATE 
  INTO TABLE name_basics
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    nconst POSITION(1),
    primary_name,
    birth_year    INTEGER EXTERNAL NULLIF birth_year = "\\N",
    death_year    INTEGER EXTERNAL NULLIF death_year = "\\N",
    primary_profession,
    known_for_titles NULLIF known_for_titles = "\\N"
  )
