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
  INFILE '${DOWNLOAD_DIR}/title.crew.tsv'
  BADFILE '${LOGS_DIR}/title.crew-bad.txt'
  DISCARDFILE '${LOGS_DIR}/title.crew-discarded.txt'
  TRUNCATE 
  INTO TABLE title_crew
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    tconst,
    directors CHAR(4000) "SUBSTR(:directors, 1, 4000)",
    writers CHAR(4000) "SUBSTR(:writers, 1, 4000)"
  )