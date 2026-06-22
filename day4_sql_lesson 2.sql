-- ============================================================
--  WOMEN TECHSTERS BOOTCAMP 5.1 — DAY 4
--  SQL Basics: Querying Databases with SQL
--  Tool: MySQL Workbench
--  Instructor Script — run block by block with students
-- ============================================================


-- ============================================================
-- BLOCK 1: SETUP — Create Database & Tables
-- ============================================================

-- Step 1: Create and select the database
CREATE DATABASE IF NOT EXISTS bootcamp_db;
USE bootcamp_db;


-- Step 2: Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id     INT PRIMARY KEY,
    name            VARCHAR(100),
    city            VARCHAR(50),
    sales           DECIMAL(10, 2),
    signup_date     DATE
);


-- Step 3: Insert sample data
INSERT INTO customers VALUES
(1, 'Amaka Obi',      'Lagos',         120000, '2024-01-10'),
(2, 'Chisom Eze',     'Abuja',          75000, '2024-02-15'),
(3, 'Ngozi Bello',    'Lagos',         200000, '2024-03-01'),
(4, 'Fatima Musa',    'Kano',           45000, '2024-03-20'),
(5, 'Tunde Awe',      'Lagos',         310000, '2024-04-05'),
(6, 'Blessing Udo',   'Port Harcourt',  88000, '2024-04-18'),
(7, 'Aisha Garba',    'Abuja',         560000, '2024-05-02'),
(8, 'Emeka Nwosu',    'Lagos',         430000, '2024-05-14');


-- Step 4: Verify — you should see all 8 rows
SELECT * FROM customers;


-- ============================================================
-- BLOCK 2: CORE SQL CLAUSES
-- Run each section one at a time and discuss the output
-- ============================================================

-- ---------------------------
-- 2A. SELECT — Choose columns
-- ---------------------------

-- Show everything
SELECT * FROM customers;

-- Show only specific columns
SELECT name, city, sales
FROM customers;

-- Show only names
SELECT name
FROM customers;


-- ---------------------------
-- 2B. WHERE — Filter rows
-- ---------------------------

-- Customers in Lagos only
SELECT name, city, sales
FROM customers
WHERE city = 'Lagos';

-- Customers in Abuja
SELECT name, city, sales
FROM customers
WHERE city = 'Abuja';

-- Customers with sales above ₦100,000
SELECT name, city, sales
FROM customers
WHERE sales > 100000;

-- Multiple conditions with AND
SELECT name, city, sales
FROM customers
WHERE city = 'Lagos'
  AND sales > 200000;

-- Multiple conditions with OR
SELECT name, city, sales
FROM customers
WHERE city = 'Lagos'
   OR city = 'Abuja';


-- ---------------------------
-- 2C. ORDER BY — Sort results
-- ---------------------------

-- Highest sales first (DESC = descending)
SELECT name, city, sales
FROM customers
ORDER BY sales DESC;

-- Lowest sales first (ASC = ascending, default)
SELECT name, city, sales
FROM customers
ORDER BY sales ASC;

-- Alphabetical by name
SELECT name, city, sales
FROM customers
ORDER BY name ASC;


-- ---------------------------
-- 2D. LIMIT — Top N rows only
-- ---------------------------

-- Top 3 customers by sales
SELECT name, city, sales
FROM customers
ORDER BY sales DESC
LIMIT 3;

-- Top 5 customers by sales
SELECT name, city, sales
FROM customers
ORDER BY sales DESC
LIMIT 5;


-- ---------------------------
-- 2E. GROUP BY + Aggregates
-- ---------------------------

-- Total sales per city
SELECT city,
       SUM(sales)   AS total_sales,
       COUNT(*)     AS num_customers,
       AVG(sales)   AS avg_sales
FROM customers
GROUP BY city
ORDER BY total_sales DESC;

-- Which city has the highest total sales?
SELECT city, SUM(sales) AS total_sales
FROM customers
GROUP BY city
ORDER BY total_sales DESC
LIMIT 1;

-- Average sales per city
SELECT city, ROUND(AVG(sales), 2) AS avg_sales
FROM customers
GROUP BY city;


-- ============================================================
-- BLOCK 2 EXERCISES — Students complete these
-- ============================================================

-- Exercise 1: Find all customers with sales above ₦100,000
SELECT name,sales FROM customers
WHERE sales > 100000;


-- Exercise 2: List the top 5 customers by sales (highest first)
SELECT name,sales FROM customers
ORDER BY sales DESC
LIMIT 5;


-- Exercise 3: Count how many customers are in each city
-- (Write your answer here)
SELECT city,COUNT(customer_id) AS customer_count FROM customers
GROUP BY city;


-- Exercise 4: Find the average sales for Lagos customers only
SELECT city,AVG(sales) As avg_sale
FROM customers
WHERE city = "lagos";


-- Exercise 5 (Bonus): Which city has the highest total sales?
SELECT city,SUM(sales) As Total_Sales
FROM customers
GROUP BY city 
ORDER BY Total_sales DESC
LIMIT 1;



-- ============================================================
-- BLOCK 2 EXERCISE ANSWER KEYS
-- ============================================================

-- Exercise 1 Answer
SELECT name, city, sales
FROM customers
WHERE sales > 100000;

-- Exercise 2 Answer
SELECT name, city, sales
FROM customers
ORDER BY sales DESC
LIMIT 5;

-- Exercise 3 Answer
SELECT city, COUNT(*) AS num_customers
FROM customers
GROUP BY city
ORDER BY num_customers DESC;

-- Exercise 4 Answer
SELECT ROUND(AVG(sales), 2) AS avg_lagos_sales
FROM customers
WHERE city = 'Lagos';

-- Exercise 5 Answer (Bonus)
SELECT city, SUM(sales) AS total_sales
FROM customers
GROUP BY city
ORDER BY total_sales DESC
LIMIT 1;


-- ============================================================
-- BLOCK 3: CASE STUDY — First Bank Nigeria
-- Customer Segmentation for a Savings Campaign
-- ============================================================

-- Step 1: Create the accounts table
CREATE TABLE IF NOT EXISTS accounts (
    customer_id           INT PRIMARY KEY,
    name                  VARCHAR(100),
    city                  VARCHAR(50),
    balance               DECIMAL(15, 2),
    account_type          VARCHAR(30),
    last_transaction_date DATE
);


-- Step 2: Insert sample data
INSERT INTO accounts VALUES
(1,  'Aisha Garba',    'Abuja',         650000, 'savings', '2024-05-10'),
(2,  'Emeka Nwosu',    'Abuja',         820000, 'current', '2024-04-28'),
(3,  'Fatima Musa',    'Abuja',         120000, 'savings', '2024-03-15'),
(4,  'Tunde Awe',      'Lagos',         530000, 'savings', '2024-05-01'),
(5,  'Ngozi Bello',    'Lagos',         200000, 'current', '2024-05-12'),
(6,  'Chisom Eze',     'Abuja',         750000, 'savings', '2024-05-08'),
(7,  'Amaka Obi',      'Kano',           95000, 'savings', '2024-04-20'),
(8,  'Blessing Udo',   'Port Harcourt', 310000, 'current', '2024-05-05'),
(9,  'Halima Yusuf',   'Abuja',         690000, 'savings', '2024-05-09'),
(10, 'Chuka Okonkwo',  'Lagos',         480000, 'current', '2024-04-15');


-- Step 3: View all accounts
SELECT * FROM accounts;


-- --------------------------------------------------
-- THE CORE CAMPAIGN QUERY
-- Goal: Find active, high-balance Abuja customers
-- --------------------------------------------------

SELECT customer_id, name, city, balance, account_type
FROM accounts
WHERE city = 'Abuja'
  AND balance > 500000
  AND last_transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY balance DESC;

-- What each condition does:
-- city = 'Abuja'              → targeting a specific city
-- balance > 500000            → only high-value customers
-- last_transaction_date >= ..  → only active customers (transacted recently)
-- ORDER BY balance DESC        → highest balance shown first


-- ============================================================
-- BLOCK 3 EXERCISES — Case Study Challenges
-- ============================================================

-- Challenge 1: Find all LAGOS customers with balance over ₦400,000
--              active in the last 30 days
SELECT *
FROM accounts
WHERE city='lagos'
AND balance > 400000
AND last_transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY);


-- Challenge 2: Count how many qualified leads exist per city
 SELECT city, COUNT(*) AS qualified_leads
FROM accounts
WHERE balance > 500000
  AND last_transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY city ORDER BY qualified_leads DESC;


-- Challenge 3: Find the average balance for savings accounts only
SELECT AVG(balance) AS Avg_balance
FROM accounts
WHERE account_type = 'savings';



-- Challenge 4: Which account type (savings/current) has the highest total balance?
SELECT account_type,SUM(balance) AS Total_balance
FROM accounts
WHERE account_type IN ('saving','current')
GROUP BY account_type
ORDER BY Total_balance DESC
LIMIT 1;



-- Challenge 5 (Stretch): Find all customers who have NOT transacted
--                         in the last 60 days (inactive accounts)
SELECT *
FROM accounts
WHERE last_transaction_date < DATE_SUB(NOW(), INTERVAL 60 DAY);


-- ============================================================
-- BLOCK 3 EXERCISE ANSWER KEYS
-- ============================================================

-- Challenge 1 Answer
SELECT customer_id, name, city, balance
FROM accounts
WHERE city = 'Lagos'
  AND balance > 400000
  AND last_transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY balance DESC;

-- Challenge 2 Answer
SELECT city, COUNT(*) AS qualified_leads
FROM accounts
WHERE balance > 500000
  AND last_transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY city
ORDER BY qualified_leads DESC;

-- Challenge 3 Answer
SELECT ROUND(AVG(balance), 2) AS avg_savings_balance
FROM accounts
WHERE account_type = 'savings';

-- Challenge 4 Answer
SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

-- Challenge 5 Answer (Stretch)
SELECT customer_id, name, city, last_transaction_date
FROM accounts
WHERE last_transaction_date < DATE_SUB(NOW(), INTERVAL 60 DAY)
ORDER BY last_transaction_date ASC;


-- ============================================================
-- HOMEWORK QUERIES — Students complete at home
-- ============================================================

-- Homework 1: Find the top 3 cities by total sales from customers table
SELECT city,SUM(sales) AS Total_sales
 FROM customers
 GROUP BY city
 ORDER BY Total_sales DESC
 LIMIT 3;

-- Homework 1 Answer
SELECT city, SUM(sales) AS total_sales
FROM customers
GROUP BY city
ORDER BY total_sales DESC
LIMIT 3;


-- ============================================================
-- END OF DAY 4 SQL SCRIPT
-- Women Techsters Bootcamp 5.1 | Tech4Dev
-- ============================================================



-- EXTRA QUERY:FIND EACH CITY'S TOTAL SALES,RANK THE CITIES AND SHOW ONLY THE TOP 5
SELECT city,SUM(sales) AS Total_sales,RANK() OVER (ORDER BY SUM(sales) DESC
) AS city_rank
FROM customers
GROUP BY city;