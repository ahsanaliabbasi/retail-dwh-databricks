CREATE OR REFRESH STREAMING TABLE silver_stores (
  CONSTRAINT valid_store_id EXPECT (store_id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_region   EXPECT (region IS NOT NULL)   ON VIOLATION DROP ROW
)
COMMENT "Cleaned and typed store master data"
AS SELECT
  CAST(store_id   AS INT)  AS store_id,
  TRIM(store_name)         AS store_name,
  TRIM(region)             AS region,
  TRIM(country)            AS country,
  TRIM(store_type)         AS store_type,
  CAST(open_date  AS DATE) AS open_date
FROM STREAM workspace.default.bronze_stores;