-- create a stage table
CREATE TABLE stg_customer_dim (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255),
    load_date DATE
);

-- load data to stage table 
INSERT INTO stg_customer_dim (customer_id, customer_name, email, address, load_date) VALUES
(1, 'John Doe', 'johndoe@email.com', '123 Main St, Anytown, USA', '2024-03-19'),
(2, 'Jane Smith', 'janesmith@email.com', '456 Elm St, Othertown, USA', '2024-03-19'),
(3, 'Alice Johnson', 'alice@email.com', '789 Oak St, Anycity, USA', '2024-03-19'),
(4, 'Bob Williams', 'bob@email.com', '321 Pine St, Anothercity, USA', '2024-03-19'),
(5, 'nitish', 'bob@email.com', '321 Pine St, Anothercity, USA', '2024-03-19'),
(6, 'ajay', 'bob@email.com', '321 Pine St, Anothercity, USA', '2024-03-19'),
(7, 'bhavya', 'sarahlee@email.com', '654 Maple St, Somecity, USA', '2024-03-19');


-- create a dim table
CREATE TABLE customer_dim (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255),
    load_date DATE
);


-- -- create the procedure 
create PROCEDURE upsert_customer_dim
as 
begin
-- 1. do some basic transformations on the source data in cte
with transformed_source as (
    -- can do any case, or join logic here
    select customer_id,
    upper(customer_name) as customer_name,
    email,
    address,
    load_date
     from stg_customer_dim
)
-- 2. use that cte in merge statement
MERGE customer_dim as target 
USING transformed_source as source
on source.customer_id=target.customer_id
WHEN matched then 
UPDATE set 
customer_name=source.customer_name,
email=source.email,
address=source.address,
load_date=GETDATE()
WHEN NOT matched THEN
INSERT(
customer_id,
customer_name,
email,
address,
load_date
)
VALUES(
source.customer_id,
source.customer_name,
source.email,
source.address,
source.load_date
);


TRUNCATE table stg_customer_dim;
select * from customer_dim;

end;

exec upsert_customer_dim

select * from stg_customer_dim;
select * from customer_dim;
