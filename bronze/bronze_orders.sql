CREATE OR REFRESH STREAMING TABLE bronze_orders
COMMENT "Raw order headers, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/orders/",
  format => "csv",
  header => true
);