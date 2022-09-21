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
  INFILE '${DOWNLOAD_DIR}/title.principals.tsv'
  BADFILE '${LOGS_DIR}/title.principals-bad.txt'
  DISCARDFILE '${LOGS_DIR}/title.principals-discarded.txt'
  TRUNCATE 
  INTO TABLE title_principals
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    tconst,
    ordering INTEGER EXTERNAL NULLIF ordering = "\\N",
    nconst,
    category  CHAR(1000) NULLIF category = "\\N",
    job       CHAR(1000) NULLIF job = "\\N",
    characters CHAR(4000) NULLIF characters = "\\N"
  )