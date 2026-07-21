CREATE OR REFRESH STREAMING TABLE bronze_returns
COMMENT "Raw return transactions, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/returns/",
  format => "csv",
  header => true
);