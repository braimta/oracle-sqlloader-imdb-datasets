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
  INFILE '${DOWNLOAD_DIR}/title.basics.tsv'
  BADFILE '${LOGS_DIR}/title.basics-bad.txt'
  DISCARDFILE '${LOGS_DIR}/title.basics-discarded.txt'
  TRUNCATE 
  INTO TABLE title_basics
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    tconst,
    title_type,
    primary_title CHAR(4000), 
    original_title CHAR(4000), 
    is_adult INTEGER EXTERNAL, 
    start_year INTEGER EXTERNAL NULLIF start_year = "\\N",
    end_year INTEGER EXTERNAL NULLIF end_year = "\\N",
    runtime_minutes FLOAT EXTERNAL NULLIF runtime_minutes = "\\N",
    genres
  )
