

CREATE  DATABASE  aws_DB ;

CREATE  SCHEMA aws_DB.EXTERNAL_STAGES ;

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
  department STRING, -- Position 6 in CSV
  salary INT,        -- Position 7 in CSV
  join_date DATE     -- Position 8 in CSV
);

COPY INTO aws_DB.public.employee_details (
  emp_id,
  first_name,
  last_name,
  email_id,
  address,
  salary
)
FROM (
  SELECT 
    t.$1, -- emp_id
    t.$2, -- first_name
    t.$3, -- last_name
    t.$4, -- email_id
    t.$5, -- address
    t.$7  -- salary (taking column 7 from CSV instead of column 6)
  FROM @aws_DB.EXTERNAL_STAGES.employee_STG t
)
FILES = ('employee_data_1.csv')
FILE_FORMAT = aws_DB.file_formats.employee_csv_format;

COPY INTO aws_DB.public.employee_details
  FROM @aws_DB.EXTERNAL_STAGES.employee_STG
  FILES = ('employee_data_1.csv')
  FILE_FORMAT = aws_DB.file_formats.employee_csv_format;

  
  select * from aws_DB.public.employee_details;




------create json 

CREATE OR REPLACE STAGE  aws_DB.EXTERNAL_STAGES.json_STG 
  URL = 's3://vitech-note-27/json//'
  STORAGE_INTEGRATION =  my_s3_int;

    list @aws_DB.EXTERNAL_STAGES.json_STG ;

    CREATE OR REPLACE TABLE aws_DB.public.MUSIC_JSON 
  (RAW_DATA    VARIANT );

 


CREATE OR REPLACE STAGE aws_DB.EXTERNAL_STAGES.json_STG 
  URL = 's3://vitech-note-27/json/' 
  STORAGE_INTEGRATION = my_s3_int;

  COPY INTO aws_DB.public.MUSIC_JSON 
  FROM @aws_DB.EXTERNAL_STAGES.json_STG 
  FILE_FORMAT = (TYPE = 'JSON');

  DESC INTEGRATION my_s3_int;

  

  LIST @aws_DB.EXTERNAL_STAGES.json_STG;

  select * from aws_DB.public.MUSIC_JSON ;

  -----how to unload the data


  COPY INTO @MANAGE_DB.EXTERNAL_STAGES.NETFLIX_STG/emp1_export_
FROM HR.VIT.EMPLOYEES
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' -- Wraps text fields with quotes to protect commas
    COMPRESSION = 'GZIP'              -- Compresses files automatically
)
HEADER = TRUE                         -- Includes column names in the first row
OVERWRITE = TRUE                      -- Replaces existing files in that folder
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
  FILE_FORMAT = aws_DB.file_formats.employee_csv_format;

  COPY INTO aws_DB.public.employee_details
  FROM @aws_DB.EXTERNAL_STAGES.employee_STG
  FILES = ('employee_data_1.csv') -- or use PATTERN = '.*employee.*\\.csv'
  FILE_FORMAT = aws_DB.file_formats.employee_csv_format;

  CREATE OR REPLACE STAGE aws_DB.EXTERNAL_STAGES.employee_STG
  URL = 's3://vitech-note-27/csv/employee/'
  STORAGE_INTEGRATION = my_s3_int;

  COPY INTO aws_DB.public.employee_details
  FROM @aws_DB.EXTERNAL_STAGES.employee_STG
  FILE_FORMAT = aws_DB.file_formats.employee_csv_format
  ON_ERROR = 'SKIP_FILE';

select * from aws_DB.public.employee_details;



------create json 

CREATE OR REPLACE STAGE  aws_DB.EXTERNAL_STAGES.json_STG 
  URL = 's3://vitech-note-27/json//'
  STORAGE_INTEGRATION =  my_s3_int;

    list @aws_DB.EXTERNAL_STAGES.json_STG ;

    CREATE OR REPLACE TABLE aws_DB.public.MUSIC_JSON 
  (RAW_DATA    VARIANT );

  ------create pipe 

  CREATE PIPE  aws_DB.public.MUSIC_PIPE
AUTO_INGEST = TRUE 
AS
 COPY INTO aws_DB.public.MUSIC_JSON 
 FROM @MANAGE_DB.EXTERNAL_STAGES.json_STG 
 FILE_FORMAT = (TYPE=JSON) ;

 describe pipe aws_DB.public.MUSIC_PIPE;

 ALTER PIPE  aws_DB.public.MUSIC_PIPE refresh;

 // Resume pipe
ALTER PIPE aws_DB.public.MUSIC_PIPE SET PIPE_EXECUTION_PAUSED = false

// Verify pipe is running again
SELECT SYSTEM$PIPE_STATUS('aws_DB.public.MUSIC_PIPE') 


 SELECT * FROM aws_DB.public.MUSIC_JSON ;

 ----how to unload the data---

select * from HR.PUBLIC.EMPLOYEES;

COPY INTO @aws_DB.EXTERNAL_STAGES.json_STG/music1_export_
FROM HR.PUBLIC.EMPLOYEES
FILE_FORMAT = (
    TYPE = 'csv'
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' -- Wraps text fields with quotes to protect commas
    COMPRESSION = 'GZIP'              -- Compresses files automatically
)
HEADER = TRUE                         -- Includes column names in the first row
OVERWRITE = TRUE                      -- Replaces existing files in that folder


select *from college.mits.student

                     -- Replaces existing files in that folder

COPY INTO @aws_DB.EXTERNAL_STAGES.json_STG/emp20_export_
FROM (
  SELECT OBJECT_CONSTRUCT(*) FROM college.mits.student
)
FILE_FORMAT = (
  TYPE = 'JSON',
  COMPRESSION = 'GZIP'
)
OVERWRITE = TRUE;