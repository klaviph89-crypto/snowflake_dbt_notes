
-----task phone number ******9678-----

create or replace database DEMO_DBt;

USE DEMO_DBt;
USE ROLE ACCOUNTADMIN;


-- Prepare table --
create or replace table cust(
  id number,
  full_name varchar, 
  email varchar,
  phone varchar,
  spent number,
  create_date DATE DEFAULT CURRENT_DATE);

  SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();

-- insert values in table --
insert into cust (id, full_name, email,phone,spent)
values
  (1,'Lewiss MacDwyer','lmacdwyer0@un.org','262-665-9168',1400),
  (2,'Ty Pettingall','tpettingall1@mayoclinic.com','734-987-7120',2540),
  (3,'Marlee Spadazzi','mspadazzi2@txnews.com','867-946-3659',1200),
  (4,'Heywood Tearney','htearney3@patch.com','563-853-8192',12300),
  (5,'Odilia Seti','oseti4@globo.com','730-451-8637',1430),
  (6,'Meggie Washtell','mwashtell5@rediff.com','568-896-6138',6000);

select * from cust ;

-- set up roles
CREATE OR REPLACE ROLE ANALYST_MASKED;
CREATE OR REPLACE ROLE ANALYST_FULL;

GRANT USAGE ON DATABASE DEMO_DBT TO ROLE ANALYST_MASKED;
GRANT USAGE ON DATABASE DEMO_DBT TO ROLE ANALYST_FULL;

-- grant select on table to roles
GRANT SELECT ON TABLE DEMO_DBt.PUBLIC.CUST TO ROLE ANALYST_MASKED;
GRANT SELECT ON TABLE DEMO_DBt.PUBLIC.CUST TO ROLE ANALYST_FULL;

GRANT USAGE ON SCHEMA DEMO_DBt.PUBLIC TO ROLE ANALYST_MASKED;
GRANT USAGE ON SCHEMA DEMO_DBt.PUBLIC TO ROLE ANALYST_FULL;

-- grant warehouse access to roles
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_MASKED;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_FULL;


-- assign roles to a user
GRANT ROLE ANALYST_MASKED TO USER SNOWFLAKE;
GRANT ROLE ANALYST_FULL TO USER SNOWFLAKE;


select current_user()

ALTER TABLE DEMO_DBT.PUBLIC.CUST 
MODIFY COLUMN phone UNSET MASKING POLICY;

-- Set up masking policy

CREATE OR REPLACE MASKING POLICY phone_policy AS (val VARCHAR) RETURNS VARCHAR ->
    CASE
        WHEN CURRENT_ROLE() IN ('ANALYST_FULL', 'ACCOUNTADMIN') THEN val
        ELSE CONCAT('*******', RIGHT(val, 4))
    END;

ALTER TABLE DEMO_DBT.PUBLIC.CUST 
MODIFY COLUMN phone SET MASKING POLICY phone_policy;
    
select * from  DEMO_DBt.PUBLIC.CUST



----------------------

DROP masking policy phone_policy;


---UNSET
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN phone 
UNSET MASKING POLICY  ;
