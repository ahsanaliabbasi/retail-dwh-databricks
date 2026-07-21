CREATE OR REFRESH STREAMING TABLE silver_orders (
  CONSTRAINT valid_order_id   EXPECT (order_id IS NOT NULL)   ON VIOLATION DROP ROW,
  CONSTRAINT valid_order_date EXPECT (order_date IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_status     EXPECT (order_status IN (
  'Completed','Cancelled','Pending'
                              ))                               ON VIOLATION DROP ROW
)
COMMENT "Cleaned order headers with proper types and null-safe date handling"
AS SELECT
  CAST(order_id    AS INT)  AS order_id,
  TRIM(customer_src_id)     AS customer_src_id,
  CAST(store_id    AS INT)  AS store_id,
  CAST(employee_id AS INT)  AS employee_id,
  CAST(order_date  AS DATE) AS order_date,
  CASE
    WHEN TRIM(ship_date)     = '' THEN NULL
    ELSE CAST(ship_date     AS DATE)
  END                       AS ship_date,
  CASE
    WHEN TRIM(delivery_date) = '' THEN NULL
    ELSE CAST(delivery_date AS DATE)
  END                       AS delivery_date,
  TRIM(order_status)        AS order_status,
  TRIM(payment_method)      AS payment_method
FROM STREAM workspace.default.bronze_orders;