CREATE OR REFRESH STREAMING TABLE bronze_inventory_snapshots
COMMENT "Raw monthly stock-on-hand snapshots, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/inventory_snapshots/",
  format => "csv",
  header => true
);