CREATE OR REFRESH STREAMING TABLE bronze_order_items
COMMENT "Raw order line items, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/order_items/",
  format => "csv",
  header => true
);