
-----scdtype 2 &3


CREATE TABLE vitech_dev_db.BRONZE.CUSTOMER (
    CID INT PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(255),
    ADDRS VARCHAR(500),
    STATUS VARCHAR(20),
    CREATTIMT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO vitech_dev_db.BRONZE.CUSTOMER(CID, NAME, EMAIL, ADDRS, STATUS)
VALUES
(111, 'John Smith', 'john.smith@email.com', 'New York, USA', 'ACTIVE'),
(211, 'Mary Johnson', 'mary.johnson@email.com', 'Chicago, USA', 'ACTIVE'),
(311, 'David Brown', 'david.brown@email.com', 'Dallas, USA', 'INACTIVE'),
(411, 'Lisa Wilson', 'lisa.wilson@email.com', 'Seattle, USA', 'ACTIVE'),
(511, 'Michael Davis', 'michael.davis@email.com', 'Boston, USA', 'PENDING');

SELECT * FROM vitech_dev_db.BRONZE.CUSTOMER


CREATE TABLE vitech_dev_db.silver.CUSTOMER_tgt (
    CID INT PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(255),
    ADDRS VARCHAR(500),
    STATUS VARCHAR(20),
    CREATTIMT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create or replace stream vitech_dev_db.BRONZE.CUSTOMER_stream on table vitech_dev_db.BRONZE.CUSTOMER

select * from vitech_dev_db.BRONZE.CUSTOMER_stream

select * from VITECH_DEV_DB.SILVER.CUSTOMER_TGT

SELECT * FROM vitech_dev_db.BRONZE.CUSTOMER

