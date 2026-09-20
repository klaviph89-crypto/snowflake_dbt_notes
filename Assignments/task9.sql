
---// Create file format and stage object
   
---CREATE OR REPLACE FILE FORMAT MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT
   -- TYPE = 'parquet';

---CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
   --- url = 's3://snowflakeparquetdemo'  
    ---FILE_FORMAT = MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT;
   




create database emp_db;

create schema emp_db.ext_stage;

CREATE OR REPLACE FILE FORMAT emp_db.ext_stage.PARQUET_FORMAT
    TYPE = 'parquet';

CREATE OR REPLACE STAGE emp_db.ext_stage.PARQUETSTAGE
    url = 's3://snowflakeparquetdemo'   
    FILE_FORMAT = emp_db.ext_stage.PARQUET_FORMAT;

    list @emp_db.ext_stage.PARQUETSTAGE;

    create table emp_db.public.parquet
    (raw_data variant);
    
    copy into emp_db.public.parquet
    from @emp_db.ext_stage.PARQUETSTAGE
    file_format=(type=parquet);

    select * from emp_db.public.parquet;

    create table emp_parquet as
    (

   select 
        $1:__index_level_0__ as index_level,
        $1:cat_id:: string as cat_id,
          $1:d as d,
          $1:date as date,
          $1:dept_id:: string as dep_id,
          $1:id:: string as id,
          $1:item_id:: string as item_id,
          $1:state_id:: string as state_id,
          $1:store_id:: string as store_id
          from emp_db.public.parquet
          );

    select * from emp_parquet ;

    count=2038050