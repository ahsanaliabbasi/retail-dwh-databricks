CREATE OR REFRESH STREAMING TABLE silver_products (
  CONSTRAINT valid_product_id  EXPECT (product_src_id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_price       EXPECT (unit_price > 0)             ON VIOLATION DROP ROW,
  CONSTRAINT valid_cost        EXPECT (unit_cost > 0)              ON VIOLATION DROP ROW,
  CONSTRAINT positive_margin   EXPECT (unit_price > unit_cost)     ON VIOLATION DROP ROW
)
COMMENT "Cleaned product catalog with derived margin columns"
AS SELECT
  TRIM(product_src_id)                               AS product_src_id,
  TRIM(product_name)                                 AS product_name,
  TRIM(category)                                     AS category,
  TRIM(subcategory)                                  AS subcategory,
  TRIM(brand)                                        AS brand,
  CAST(unit_price  AS DECIMAL(10,2))                 AS unit_price,
  CAST(unit_cost   AS DECIMAL(10,2))                 AS unit_cost,
  ROUND(unit_price - unit_cost, 2)                   AS gross_margin,
  ROUND((unit_price - unit_cost) / unit_price, 4)   AS margin_pct,
  CAST(supplier_id AS INT)                           AS supplier_id,
  TRIM(supplier_name)                                AS supplier_name
FROM STREAM workspace.default.bronze_products;