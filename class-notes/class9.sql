

CREATE DATABASE  aws_DB ;

CREATE SCHEMA aws_DB.EXTERNAL_STAGES ;

use aws_DB;

CREATE OR REPLACE STAGE aws_DB.EXTERNAL_STAGES.employee_STG 
URL = "s3://vitech-note-27/csv/" ;

LIST @aws_DB.EXTERNAL_STAGES.employee_STG  ;

CREATE OR REPLACE STORAGE INTEGRATION my_s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::523220341718:role/snowflake'
  STORAGE_ALLOWED_LOCATIONS = ('s3://vitech-note-27/csv/', 's3://vitech-note-27/json/')
  -- Optional: STORAGE_BLOCKED_LOCATIONS = ('s3://my-snowflake-data-bucket/incoming/private/')
  ;

describe integration my_s3_int


-- Create an external stage referencing the storage integration
CREATE OR REPLACE STAGE  aws_DB.EXTERNAL_STAGES.employee_STG 
  URL = 's3://vitech-note-27/csv/'
  STORAGE_INTEGRATION =  my_s3_int;
  ---FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1);

    list @aws_DB.EXTERNAL_STAGES.employee_STG  ;

  CREATE OR REPLACE TABLE aws_DB.public.employee_details (
  emp_id INT,
  first_name STRING,
  last_name STRING,
  email_id STRING,
  address STRING,
  department STRING,   -- Moved string column here to match CSV position 6
  salary INT,
  join_date INT
);


  COPY INTO aws_DB.public.employee_details
  FROM @aws_DB.EXTERNAL_STAGES.employee_STG
  FILES = ('employee_data_1.csv') -- or use PATTERN = '.*employee.*\\.csv'
  FILE_FORMAT = aws_DB.file_formats.employee_csv_format;

  select * from aws_DB.public.employee_details;





------create json 

CREATE OR REPLACE STAGE  aws_DB.EXTERNAL_STAGES.json_STG 
  URL = 's3://vitech-note-27/json//'
  STORAGE_INTEGRATION =  my_s3_int;

    list @aws_DB.EXTERNAL_STAGES.json_STG ;

    CREATE OR REPLACE TABLE aws_DB.public.MUSIC_JSON 
  (RAW_DATA    VARIANT );

 COPY INTO aws_DB.public.MUSIC_JSON 
 FROM @MANAGE_DB.EXTERNAL_STAGES.json_STG 
 FILE_FORMAT = (TYPE=JSON) ;


CREATE OR REPLACE STAGE aws_DB.EXTERNAL_STAGES.json_STG 
  URL = 's3://vitech-note-27/json/' 
  STORAGE_INTEGRATION = my_s3_int;

  DESC INTEGRATION my_s3_int;

  

  LIST @aws_DB.EXTERNAL_STAGES.json_STG;

  select * from aws_DB.public.MUSIC_JSON ;