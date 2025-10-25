-- ===========================================
-- SQL Project: eCommerce Data Analysis
-- Task 4 – Elevate Labs Data Analyst Internship
-- Tools: MySQL / PostgreSQL / SQLite
-- ===========================================

-- Step 1: Create Database
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

-- Step 2: Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 3: Insert Sample Data
INSERT INTO customers VALUES
(101, 'Alice Johnson', 'alice@example.com', '2023-01-15'),
(102, 'Bob Williams', 'bob@example.com', '2023-02-05'),
(103, 'Charlie Brown', 'charlie@example.com', '2023-02-20'),
(104, 'Diana Miller', 'diana@example.com', '2023-03-10');

INSERT INTO products VALUES
(1, 'Laptop', 'Technology', 75000.00),
(2, 'Smartphone', 'Technology', 25000.00),
(3, 'Office Chair', 'Furniture', 8000.00),
(4, 'Printer', 'Office Supplies', 15000.00),
(5, 'Desk', 'Furniture', 12000.00);

INSERT INTO orders VALUES
(201, 101, '2023-08-01', 'Delivered'),
(202, 102, '2023-08-03', 'Delivered'),
(203, 103, '2023-08-10', 'Cancelled'),
(204, 104, '2023-08-15', 'Delivered'),
(205, 101, '2023-09-01', 'Delivered');

INSERT INTO order_items VALUES
(301, 201, 1, 1),
(302, 201, 2, 1),
(303, 202, 3, 2),
(304, 204, 4, 1),
(305, 205, 5, 1);

-- Step 4: Analytical Queries (Deliverable Part)
-- a. Total Monthly Revenue (Using GROUP BY, ORDER BY)
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * p.price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY month
ORDER BY month;

-- b. Top 3 Customers by Spending
SELECT
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- c. Product Category Performance
SELECT
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- d. Subquery: Customers Whose Spending is Above Average
SELECT customer_id, customer_name, total_spent FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
) AS spending_data
WHERE total_spent > (
    SELECT AVG(total_spent) FROM (
        SELECT SUM(oi.quantity * p.price) AS total_spent
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        JOIN products p ON oi.product_id = p.product_id
        WHERE o.status = 'Delivered'
        GROUP BY o.customer_id
    ) AS avg_data
);

-- e. Create a View: Daily Sales Summary
CREATE VIEW daily_sales_summary AS
SELECT
    o.order_date,
    SUM(oi.quantity * p.price) AS daily_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_date;

-- f. Optimize Queries Using Indexes
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_products_category ON products(category);

-- Step 5: Query the View to Verify
SELECT * FROM daily_sales_summary ORDER BY oRDER_DATE;

