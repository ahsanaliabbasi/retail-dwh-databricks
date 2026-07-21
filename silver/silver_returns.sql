CREATE OR REFRESH STREAMING TABLE silver_returns (
  CONSTRAINT valid_return_id  EXPECT (return_id IS NOT NULL)     ON VIOLATION DROP ROW,
  CONSTRAINT valid_item_ref   EXPECT (order_item_id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_return_date EXPECT (return_date IS NOT NULL)  ON VIOLATION DROP ROW,
  CONSTRAINT valid_refund     EXPECT (refund_amount >= 0)        ON VIOLATION DROP ROW
)
COMMENT "Cleaned return transactions"
AS SELECT
  CAST(return_id      AS INT)           AS return_id,
  CAST(order_item_id  AS INT)           AS order_item_id,
  CAST(return_date    AS DATE)          AS return_date,
  TRIM(return_reason)                   AS return_reason,
  CAST(refund_amount  AS DECIMAL(10,2)) AS refund_amount
FROM STREAM workspace.default.bronze_returns;