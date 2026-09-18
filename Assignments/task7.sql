
---CRETAE EXT STAGE
---CREATE OR REPLACE STAGE VITECH_DEV_DB.STAGES.AWS_EXT_STAGE
 ----url= 's3://bucketsnowflakes3/' ; 

------ Creating ORDERS table

---CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),

    SUBCATEGORY VARCHAR(30));


---create database vitech_dev_dbt;


CREATE OR REPLACE TABLE vitech_dev_dbt.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));	

    select * from vitech_dev_dbt.PUBLIC.ORDERS;

    COPY INTO VITECH_DEV_DBT.PUBLIC.ORDERS
 FROM 's3://bucketsnowflakes3/OrderDetails.csv'
 ;
    
  
create or replace schema vitech_dev_dbt.stages;

CREATE OR REPLACE STAGE VITECH_DEV_DBt.STAGES.AWS_EXT_STAGE
url= 's3://bucketsnowflakes3/' ;

list @VITECH_DEV_DBt.STAGES.AWS_EXT_STAGE 



COPY INTO vitech_dev_dbt.PUBLIC.ORDERS 
FROM @VITECH_DEV_DBt.STAGES.AWS_EXT_STAGE 
FILES = ('OrderDetails.csv')
FILE_FORMAT = (TYPE = 'CSV', SKIP_HEADER = 1);

    
 select * from VITECH_DEV_DBT.PUBLIC.ORDERS;

 





