# SQL-
# Project: SQL for Data Analysis

## Task 4 - Data Analyst Internship at Elevate Labs

This repository contains the deliverables for the SQL data analysis task.

### Objective
The goal of this project is to demonstrate proficiency in SQL by writing queries to extract and analyze data from a relational database. The analysis aims to answer key business questions related to sales, customers, and products [file:12].

### Database Schema
The queries were written for a standard ecommerce database with the following tables:
- `customers` (customer_id, customer_name, email)
- `products` (product_id, product_name, category, price)
- `orders` (order_id, customer_id, order_date)
- `order_items` (order_item_id, order_id, product_id, quantity)

### Tools Used
- **Database:** Standard SQL compatible with MySQL, PostgreSQL, or SQLite [file:12].
- **Editor:** Any standard text editor or SQL IDE.

### Analysis & Queries
The `analysis.sql` file contains a series of queries to perform the following analyses:
1.  **Monthly Revenue Calculation:** Aggregated total sales revenue for each month to track performance over time.
2.  **Top Customer Identification:** Identified the top 5 customers by their total spending using `JOIN`s and aggregate functions.
3.  **Product Performance Analysis:** Used a subquery to find products that are ordered more frequently than average.
4.  **View Creation:** Created a `VIEW` to provide a simplified, reusable summary of daily sales, improving query efficiency for business users.
5.  **Query Optimization:** Included an example of creating an `INDEX` to improve the performance of queries on the database.

### How to Use
1.  Set up the database schema and populate it with sample ecommerce data.
2.  Run the queries in the `analysis.sql` file using a compatible SQL client.
3.  The expected output for each query is provided in the project submission.
