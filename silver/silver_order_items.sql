CREATE OR REFRESH STREAMING TABLE silver_order_items (
  CONSTRAINT valid_item_id   EXPECT (order_item_id IS NOT NULL)              ON VIOLATION DROP ROW,
  CONSTRAINT valid_order_ref EXPECT (order_id IS NOT NULL)                   ON VIOLATION DROP ROW,
  CONSTRAINT valid_quantity  EXPECT (quantity > 0)                           ON VIOLATION DROP ROW,
  CONSTRAINT valid_price     EXPECT (unit_price_at_sale > 0)                 ON VIOLATION DROP ROW,
  CONSTRAINT valid_discount  EXPECT (discount_pct >= 0 AND discount_pct < 1) ON VIOLATION DROP ROW
)
COMMENT "Cleaned order line items with net amount derived column"
AS SELECT
  CAST(order_item_id      AS INT)           AS order_item_id,
  CAST(order_id           AS INT)           AS order_id,
  TRIM(product_src_id)                      AS product_src_id,
  CAST(quantity           AS INT)           AS quantity,
  CAST(unit_price_at_sale AS DECIMAL(10,2)) AS unit_price_at_sale,
  CAST(discount_pct       AS DECIMAL(4,2))  AS discount_pct,
  ROUND(
    CAST(quantity           AS INT)           *
    CAST(unit_price_at_sale AS DECIMAL(10,2)) *
    (1 - CAST(discount_pct  AS DECIMAL(4,2))), 2
  )                                         AS net_amount
FROM STREAM workspace.default.bronze_order_items;