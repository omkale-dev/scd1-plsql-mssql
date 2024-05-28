# SCD (Slowly Changing Dimension) Basic Implementation PLSQL

This README provides instructions for setting up and running a Slowly Changing Dimension (SCD) implementation script in SQL Server.

## Overview

This script demonstrates a basic implementation of SCD using a staging table (`stg_customer_dim`) and a target dimension table (`customer_dim`). It performs an upsert operation to update existing records and insert new records based on the source data in the staging table.

## Usage

1. **Set Up SQL Server:**
   - Ensure you have Docker installed on your machine.
   - Spin up a SQL Server container using the provided Docker Compose template or any other method of your choice.

2. **Create Tables and Procedure:**
   - Execute the provided SQL script to create the staging and dimension tables, as well as the stored procedure (`upsert_customer_dim`) for performing the upsert operation.

3. **Load Data to Staging Table:**
   - Insert sample data into the `stg_customer_dim` table using the provided INSERT statements.

4. **Execute Upsert Procedure:**
   - Execute the stored procedure `upsert_customer_dim` to perform the upsert operation on the `customer_dim` table based on the data in the staging table.

5. **View Results:**
   - View the updated records in the `customer_dim` table to see the changes.
   - Optionally, you can also view the contents of the staging table (`stg_customer_dim`) and the dimension table (`customer_dim`) to verify the results.

## Docker Setup

To spin up a SQL Server instance using Docker, use the provided Docker Compose template:

```bash
docker-compose up -d
```

## Note

This README is provided for reference. Please ensure you have a SQL Server environment set up and running before executing the SQL script.

---

This script is designed to help you understand and implement a basic SCD process in SQL Server. 
Happy coding! 🚀