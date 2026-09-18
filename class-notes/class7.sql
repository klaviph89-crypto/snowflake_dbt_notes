

CREATE  DATABASE  VITECH_DEV_DB_ex ;



CREATE OR REPLACE TABLE VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT (
  Loan_ID STRING,
  loan_status STRING,
  Principal STRING,
  terms STRING,
  effective_date STRING,
  due_date STRING,
  paid_off_time STRING,
  past_due_days STRING,
  age STRING,
  education STRING,
  Gender STRING);							


SELECT * FROM VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT; ---url= 's3://bucketsnowflakes3/Loan_payments_data.csv'


COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM 's3://bucketsnowflakes3/Loan_payments_data.csv'
 ;


COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM 's3://bucketsnowflakes3/Loan_payments_data.csv'
 FILE_FORMAT = (TYPE = CSV , SKIP_HEADER= 1) ;


------------------

 COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM 's3://bucketsnowflakes3/Loan_payments_data-1.csv'
 FILE_FORMAT = (TYPE = CSV , SKIP_HEADER= 1) ;
 
 COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM 's3://bucketsnowflakes3/Loan_payments_data-2.csv'
 FILE_FORMAT = (TYPE = CSV , SKIP_HEADER= 1) ;
 
 COPY INTO VITECH_DEV_DB.PUBLIC.LOAN_PAYMENT
 FROM 's3://bucketsnowflakes3/Loan_payments_data-3.csv'
 FILE_FORMAT = (TYPE = CSV , SKIP_HEADER= 1) ;


 ---------------------------------------------------


 CREATE SCHEMA VITECH_DEV_DB_ex.STAGES ;

---CRETAE INT SATGE 
CREATE OR REPLACE STAGE VITECH_DEV_DB_ex.STAGES.INT_STAGE ;

----LIST OF FILES
LIST @VITECH_DEV_DB_ex.STAGES.INT_STAGE;



 SELECT * FROM VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT;

 COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM @VITECH_DEV_DB.STAGES.INT_STAGE
  FILE_FORMAT = (TYPE = 'CSV' , SKIP_HEADER= 1) ;



---CRETAE EXT STAGE 
CREATE OR REPLACE STAGE VITECH_DEV_DB_ex.STAGES.AWS_EXT_STAGE 
 url= 's3://bucketsnowflakes3/' ;


--LIST THE FILES

LIST @VITECH_DEV_DB_ex.STAGES.AWS_EXT_STAGE ;



COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
 FROM @VITECH_DEV_DB.STAGES.AWS_EXT_STAGE
  FILE_FORMAT = (TYPE = CSV , SKIP_HEADER= 1) 
  FILEs = ('Loan_payments_data.csv') ;


COPY INTO VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
FROM @VITECH_DEV_DB.STAGES.AWS_EXT_STAGE
FILE_FORMAT = (TYPE = CSV, SKIP_HEADER = 1)
PATTERN = '.*Loan_payments.*\.csv';


 


select * from VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT;

select gender from VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT;

select gender,count(*)  as tot_count
from VITECH_DEV_DB_ex.PUBLIC.LOAN_PAYMENT
group by gender
order by gender asc;



CREATE OR REPLACE TABLE VITECH_DEV_DB.PUBLIC.LOAN_PAYMENT_V1 (
  Loan_ID STRING,
  loan_status STRING,
  Principal STRING,
  terms STRING,
  effective_date STRING,
  due_date STRING,
  paid_off_time STRING,
  past_due_days STRING,
  age STRING,
  education STRING,
  Gender STRING);							





