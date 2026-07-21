CREATE OR REFRESH STREAMING TABLE bronze_customer_segment_bridge
COMMENT "Raw customer-to-marketing-segment mapping, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/customer_segment_bridge/",
  format => "csv",
  header => true
);