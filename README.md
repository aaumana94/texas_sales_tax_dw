## Texas Sales Tax Data Warehouse 

## Overview
- This repository caontains information on the entire ETL process form start to finish for Texas Sales Tax
- The data comes from the Sales Tax Allocation dataset CSV + API https://data.texas.gov/dataset/Sales-Tax-Allocation-City/vfba-b57j and https://data.texas.gov/resource/vfba-b57j.json
- The Warehouse enables trend analysis across:
  
  a. Net Payments
  
  b. Comparable payments
  
  c. Percent change
  
  d. City-level comparisons
  
  e. Monthly, quarterly and yearly aggregations

### Extract
- Raw data was uploaded  to Google Cloud Storage (https://storage.googleapis.com/aybe-texas-tax-bucket/texas_sales_tax_api_data.csv)
- The extract process included:

  a. Loading CSV data into BigQuery staging tables
  
  b. Extracting API based data into "stg_texas_sales_api"
  
  c. Standardizing column formats (dates, numeric types)

- Scripts used for extraction can be viewed in the SQL file within this repo

### Data Modeling
- The dimensional model was developed using **DbSchema**
- The data warehouse uses a **star schema** with:
  
  a. 'dim_location'
  
  b. 'dim_date'
  
  c. 'fact_city_payments'
  
- Each dimension includes a surrogate key ('location_id', 'date_id')
- The fact table links the dimensions and stores financial measures

### Star Schema Diagram 



