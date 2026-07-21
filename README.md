# Retail Data Warehouse — Databricks Lakeflow

End-to-end ETL pipeline built on Databricks using the Medallion Architecture
(Bronze → Silver → Gold) for a simulated retail/e-commerce domain.

## Architecture
- **Bronze**: Raw ingestion from 9 source files (customers, orders, products,
  stores, employees, returns, inventory snapshots, order items, customer segments)
- **Silver**: Typed, cleaned, validated with DQ constraints (EXPECT),
  MDM customer deduplication across 3 source systems
- **Gold**: Star schema warehouse — SCD Type 1 & 2 dimensions, 3 fact tables
  at different grains, conformed date dimension (role-playing), bridge table

## Tech Stack
- Databricks Lakeflow (Declarative Pipelines)
- Delta Lake
- Spark SQL + PySpark
- Unity Catalog
- Azure Data Lake Storage (via Databricks Volumes)

## Data Model
- dim_customer (SCD Type 2)
- dim_product (SCD Type 2)
- dim_store (SCD Type 1)
- dim_employee (SCD Type 1)
- dim_date (conformed, role-playing)
- bridge_customer_segment (many-to-many with weighting factors)
- fact_sales (transaction grain)
- fact_returns (transaction grain)
- fact_inventory_snapshot (periodic snapshot grain)

## Data Quality
- EXPECT constraints on every silver table
- Row count reconciliation across all layers
- Referential integrity checks
- MDM deduplication: 386 raw customer records → ~260 golden records
- SCD2 CDC handling with two-step MERGE pattern
