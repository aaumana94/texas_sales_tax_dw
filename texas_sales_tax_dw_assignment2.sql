--Creating the dim_location table--
--This table stores unique combinations of state, county, city and zip code--

CREATE OR REPLACE TABLE `striking-audio-477100-e8`.`sales_tax_dw`.`dim_location` (
  location_id INT64,
  state_code STRING,
  state STRING,
  county STRING,
  city STRING,
  zip_code STRING
);

--Populating dim_location--
--Loading unique, cleaned location records from the stg_city_alloc folder--
--Generating surrogate keys using ROW_NUMBER--

INSERT INTO `striking-audio-477100-e8`.`sales_tax_dw`.`dim_location`
(location_id, state_code, state, county, city, zip_code)
SELECT
  ROW_NUMBER() OVER() AS location_id,
  TRIM(state_code),
  TRIM(state),
  TRIM(county),
  TRIM(city),
  LPAD(TRIM(zip_code), 5, '0') AS zip_code
  FROM(
    SELECT DISTINCT
    state_code,
    state,
    county,
    city,
    zip_code
    FROM `striking-audio-477100-e8`.`sales_tax_dw`.`stg_city_alloc`
  );

