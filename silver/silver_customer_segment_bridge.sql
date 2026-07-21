CREATE OR REFRESH STREAMING TABLE silver_customer_segment_bridge (
  CONSTRAINT valid_customer EXPECT (customer_src_id IS NOT NULL)           ON VIOLATION DROP ROW,
  CONSTRAINT valid_segment  EXPECT (marketing_segment IS NOT NULL)         ON VIOLATION DROP ROW,
  CONSTRAINT valid_weight   EXPECT (weighting_factor > 0
                             AND    weighting_factor <= 1)                  ON VIOLATION DROP ROW
)
COMMENT "Cleaned customer-to-marketing-segment bridge with weighting factors"
AS SELECT
  LOWER(TRIM(customer_src_id))           AS customer_src_id,
  TRIM(marketing_segment)                AS marketing_segment,
  CAST(weighting_factor AS DECIMAL(5,4)) AS weighting_factor
FROM STREAM workspace.default.bronze_customer_segment_bridge;