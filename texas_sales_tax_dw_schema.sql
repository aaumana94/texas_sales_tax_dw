IF DB_ID('') IS NULL EXECUTE('CREATE DATABASE [];');
GO

USE [];
GO

IF SCHEMA_ID('sales_tax_dw_subject_area') IS NULL EXECUTE('CREATE SCHEMA [sales_tax_dw_subject_area];');
GO

CREATE  TABLE sales_tax_dw_subject_area.dim_date ( 
	date_id              int    QAUTO_INCREMENTE  NOT NULL,
	full_date            date      NOT NULL,
	year                 int      NOT NULL,
	month                int      NOT NULL,
	day                  date      NOT NULL,
	CONSTRAINT pk_dim_date PRIMARY KEY  ( date_id ) 
 );
GO

CREATE  TABLE sales_tax_dw_subject_area.dim_location ( 
	location_id          int    QAUTO_INCREMENTE  NOT NULL,
	state_code           varchar(10)      NOT NULL,
	state                varchar(100)      NOT NULL,
	county               varchar(100)      NOT NULL,
	city                 varchar(100)      NOT NULL,
	zip_code             varchar(10)      NOT NULL,
	CONSTRAINT pk_dim_location PRIMARY KEY  ( location_id ) 
 );
GO

CREATE  TABLE sales_tax_dw_subject_area.dim_rate_type ( 
	rate_type_id         int    QAUTO_INCREMENTE  NOT NULL,
	rate_type_description varchar(50)      NOT NULL,
	CONSTRAINT pk_dim_rate_type PRIMARY KEY  ( rate_type_id ) 
 );
GO

CREATE  TABLE sales_tax_dw_subject_area.fact_sales_tax ( 
	sales_tax_id         int    QAUTO_INCREMENTE  NOT NULL,
	rate                 decimal(5,2)      NOT NULL,
	state_code           varchar      NOT NULL,
	city                 varchar      NOT NULL,
	state                varchar      NOT NULL,
	county               varchar      NOT NULL,
	zip_code             varchar      NULL,
	effective_date       date      NOT NULL,
	type                 varchar      NOT NULL,
	combined_rate        decimal(6,4)      NOT NULL,
	state_rate           decimal(6,4)      NOT NULL,
	county_rate          decimal(6,4)      NOT NULL,
	city_rate            decimal(6,4)      NOT NULL,
	special_rate         decimal(6,4)      NULL,
	jurisdiction_code    varchar      NULL,
	rate_type            varchar      NULL,
	location_id          int      NOT NULL,
	date_id              int      NOT NULL,
	rate_type_id         int      NOT NULL,
	CONSTRAINT pk_fact_sales_tax PRIMARY KEY  ( sales_tax_id, location_id ) 
 );
GO

ALTER TABLE sales_tax_dw_subject_area.fact_sales_tax ADD CONSTRAINT fk_fact_sales_tax_dim_location FOREIGN KEY ( location_id ) REFERENCES sales_tax_dw_subject_area.dim_location( location_id );
GO

ALTER TABLE sales_tax_dw_subject_area.fact_sales_tax ADD CONSTRAINT fk_fact_sales_tax_dim_date FOREIGN KEY ( date_id ) REFERENCES sales_tax_dw_subject_area.dim_date( date_id );
GO

ALTER TABLE sales_tax_dw_subject_area.fact_sales_tax ADD CONSTRAINT fk_fact_sales_tax FOREIGN KEY ( rate_type_id ) REFERENCES sales_tax_dw_subject_area.dim_rate_type( rate_type_id );
GO

