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
  INFILE '${DOWNLOAD_DIR}/title.episode.tsv'
  BADFILE '${LOGS_DIR}/title.episode-bad.txt'
  DISCARDFILE '${LOGS_DIR}/title.episode-discarded.txt'
  TRUNCATE 
  INTO TABLE title_episodes
  FIELDS TERMINATED BY '\t'
  TRAILING NULLCOLS
  (
    tconst,
    parent_tconst,
    season_number  INTEGER EXTERNAL NULLIF season_number = "\\N",
    episode_number INTEGER EXTERNAL NULLIF episode_number = "\\N"
  )