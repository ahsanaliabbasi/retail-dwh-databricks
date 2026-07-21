CREATE OR REFRESH STREAMING TABLE silver_employees (
  CONSTRAINT valid_employee_id EXPECT (employee_id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_store       EXPECT (store_id IS NOT NULL)    ON VIOLATION DROP ROW
)
COMMENT "Cleaned and typed employee and sales rep data"
AS SELECT
  CAST(employee_id AS INT)  AS employee_id,
  TRIM(employee_name)       AS employee_name,
  CAST(store_id   AS INT)   AS store_id,
  CAST(manager_id AS INT)   AS manager_id,
  CAST(hire_date  AS DATE)  AS hire_date,
  TRIM(role)                AS role
FROM STREAM workspace.default.bronze_employees;