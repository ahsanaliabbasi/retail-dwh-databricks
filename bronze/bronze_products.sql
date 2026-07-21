CREATE OR REFRESH STREAMING TABLE bronze_products
COMMENT "Raw product catalog, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/products/initial/",
  format => "csv",
  header => true
);