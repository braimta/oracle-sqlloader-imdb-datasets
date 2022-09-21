OPTIONS
(
  -- 
  PARALLEL=FALSE,
  ROWS=65534,        -- 65534 = 64KB
  BINDSIZE=25000000, -- 1000000 = 1MB
  READSIZE=25000000,
  ERRORS=1000000,    -- after 1 million errors, abort.
  SKIP=1
)
-- File are UTF-8 and for BOM check, I added it for clarification
LOAD DATA CHARACTERSET UTF8 BYTEORDERMARK CHECK
  INFILE '${DOWNLOAD_DIR}/title.akas.tsv'
  BADFILE '${LOGS_DIR}/title.akas-bad.txt'
  DISCARDFILE '${LOGS_DIR}/title.akas-discarded.txt'
  TRUNCATE 
  INTO TABLE title_akas
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    title_id,
    ordering   INTEGER EXTERNAL,
    title      CHAR(4000),
    region     NULLIF region = "\\N",
    language   NULLIF language = "\\N",
    types      NULLIF types = "\\N",
    attributes  NULLIF attributes = "\\N",
    is_original_title INTEGER EXTERNAL NULLIF is_original_title = "\\N"
  )