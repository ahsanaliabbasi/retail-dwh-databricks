CREATE OR REFRESH STREAMING TABLE bronze_employees
COMMENT "Raw employee and sales rep data, ingested as-is"
AS SELECT *,
  _metadata.file_path AS source_file,
  current_timestamp() AS ingested_at
FROM STREAM read_files(
  "/Volumes/workspace/default/raw_data/employees/",
  format => "csv",
  header => true
);