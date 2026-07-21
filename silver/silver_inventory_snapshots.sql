CREATE OR REFRESH STREAMING TABLE silver_inventory_snapshots (
  CONSTRAINT valid_date     EXPECT (snapshot_date IS NOT NULL)  ON VIOLATION DROP ROW,
  CONSTRAINT valid_store    EXPECT (store_id IS NOT NULL)       ON VIOLATION DROP ROW,
  CONSTRAINT valid_product  EXPECT (product_src_id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_stock    EXPECT (quantity_on_hand >= 0)      ON VIOLATION DROP ROW
)
COMMENT "Cleaned monthly inventory snapshots"
AS SELECT
  CAST(snapshot_date    AS DATE) AS snapshot_date,
  CAST(store_id         AS INT)  AS store_id,
  TRIM(product_src_id)           AS product_src_id,
  CAST(quantity_on_hand AS INT)  AS quantity_on_hand
FROM STREAM workspace.default.bronze_inventory_snapshots;