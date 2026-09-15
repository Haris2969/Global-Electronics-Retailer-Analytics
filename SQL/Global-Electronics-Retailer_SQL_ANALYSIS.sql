-- ============================================================
-- GLOBAL ELECTRONICS RETAILER ANALYTICS
-- Complete SQL Business Analysis
-- PostgreSQL
-- ============================================================


-- ============================================================
-- 1. DATA VALIDATION
-- ============================================================

-- 1.1 Customers row count
SELECT COUNT(*) AS customers_count
FROM customers;


-- 1.2 Products row count
SELECT COUNT(*) AS products_count
FROM products;


-- 1.3 Sales row count
SELECT COUNT(*) AS sales_count
FROM sales;


-- 1.4 Stores row count
SELECT COUNT(*) AS stores_count
FROM stores;


-- 1.5 Exchange Rates row count
SELECT COUNT(*) AS exchange_rates_count
FROM exchange_rates;


-- 1.6 Data Dictionary row count
SELECT COUNT(*) AS data_dictionary_count
FROM data_dictionary;


-- 1.7 Unmatched Customers
SELECT COUNT(*) AS unmatched_customers
FROM sales s
LEFT JOIN customers c
    ON s.customerkey = c."CustomerKey"
WHERE c."CustomerKey" IS NULL;


-- 1.8 Unmatched Products
SELECT COUNT(*) AS unmatched_products
FROM sales s
LEFT JOIN products p
    ON s.productkey = p.productkey
WHERE p.productkey IS NULL;


-- 1.9 Unmatched Stores
SELECT COUNT(*) AS unmatched_stores
FROM sales s
LEFT JOIN stores st
    ON s.storekey = st.storekey
WHERE st.storekey IS NULL;


-- 1.10 Unmatched Exchange Rates
SELECT COUNT(*) AS unmatched_exchange_rates
FROM sales s
LEFT JOIN exchange_rates er
    ON s.orderdate::date = er.date
   AND s.currencycode = er.currencycode
WHERE er.date IS NULL;



-- ============================================================
-- 2. CORE BUSINESS KPIs
-- ============================================================

-- 2.1 Total Sales
SELECT
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey;


-- 2.2 Total Orders
SELECT
    COUNT(DISTINCT ordernumber) AS total_orders
FROM sales;


-- 2.3 Total Quantity
SELECT
    SUM(quantity) AS total_quantity
FROM sales;


-- 2.4 Total Customers
SELECT
    COUNT(DISTINCT "CustomerKey") AS total_customers
FROM customers;


-- 2.5 Active Customers
SELECT
    COUNT(DISTINCT customerkey) AS active_customers
FROM sales;


-- 2.6 Average Order Value
SELECT
    SUM(s.quantity * p.unitpriceusd)::numeric
    / COUNT(DISTINCT s.ordernumber) AS average_order_value
FROM sales s
JOIN products p
    ON s.productkey = p.productkey;


-- 2.7 Average Quantity per Order
SELECT
    SUM(quantity)::numeric
    / COUNT(DISTINCT ordernumber) AS average_quantity_per_order
FROM sales;


-- 2.8 Sales per Active Customer
SELECT
    SUM(s.quantity * p.unitpriceusd)::numeric
    / COUNT(DISTINCT s.customerkey) AS sales_per_active_customer
FROM sales s
JOIN products p
    ON s.productkey = p.productkey;


-- 2.9 Customer Purchase Rate
SELECT
    COUNT(DISTINCT s.customerkey)::numeric
    / COUNT(DISTINCT c."CustomerKey") * 100
    AS customer_purchase_rate
FROM customers c
LEFT JOIN sales s
    ON s.customerkey = c."CustomerKey";


-- 2.10 Repeat Customers
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT customerkey
    FROM sales
    GROUP BY customerkey
    HAVING COUNT(DISTINCT ordernumber) > 1
) AS repeat_customer_list;


-- 2.11 Repeat Customer Rate
SELECT
    COUNT(*)::numeric
    / (
        SELECT COUNT(DISTINCT customerkey)
        FROM sales
    ) * 100 AS repeat_customer_rate
FROM (
    SELECT customerkey
    FROM sales
    GROUP BY customerkey
    HAVING COUNT(DISTINCT ordernumber) > 1
) AS repeat_customer_list;


-- 2.12 Average Orders per Active Customer
SELECT
    COUNT(DISTINCT ordernumber)::numeric
    / COUNT(DISTINCT customerkey)
    AS average_orders_per_active_customer
FROM sales;



-- ============================================================
-- 3. PRODUCT ANALYSIS
-- ============================================================

-- 3.1 Sales by Product Category
SELECT
    p.category,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.category
ORDER BY total_sales DESC;


-- 3.2 Top 10 Products by Sales
SELECT
    p.productname,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.productname
ORDER BY total_sales DESC
LIMIT 10;


-- 3.3 Sales by Product Subcategory
SELECT
    p.subcategory,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.subcategory
ORDER BY total_sales DESC;


-- 3.4 Sales by Brand
SELECT
    p.brand,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.brand
ORDER BY total_sales DESC;


-- 3.5 Sales by Product Color
SELECT
    p.color,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.color
ORDER BY total_sales DESC;


-- 3.6 Quantity by Product Category
SELECT
    p.category,
    SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.category
ORDER BY total_quantity DESC;


-- 3.7 Orders by Product Category
SELECT
    p.category,
    COUNT(DISTINCT s.ordernumber) AS total_orders
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.category
ORDER BY total_orders DESC;



-- ============================================================
-- 4. CUSTOMER ANALYSIS
-- ============================================================

-- 4.1 Top 10 Customers by Sales
SELECT
    c."Name" AS customer_name,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN customers c
    ON s.customerkey = c."CustomerKey"
GROUP BY c."Name"
ORDER BY total_sales DESC
LIMIT 10;


-- 4.2 Customer Sales
SELECT
    c."Name" AS customer_name,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN customers c
    ON s.customerkey = c."CustomerKey"
GROUP BY c."Name"
ORDER BY total_sales DESC;


-- 4.3 Orders per Customer
SELECT
    c."Name" AS customer_name,
    COUNT(DISTINCT s.ordernumber) AS total_orders
FROM sales s
JOIN customers c
    ON s.customerkey = c."CustomerKey"
GROUP BY c."Name"
ORDER BY total_orders DESC;


-- 4.4 Active Customers by Country
SELECT
    st.country,
    COUNT(DISTINCT s.customerkey) AS active_customers
FROM sales s
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY active_customers DESC;


-- 4.5 Customer Purchase Rate by Country
SELECT
    st.country,
    COUNT(DISTINCT s.customerkey)::numeric
    / COUNT(DISTINCT c."CustomerKey") * 100
    AS customer_purchase_rate
FROM stores st
CROSS JOIN customers c
LEFT JOIN sales s
    ON s.storekey = st.storekey
   AND s.customerkey = c."CustomerKey"
GROUP BY st.country
ORDER BY customer_purchase_rate DESC;



-- ============================================================
-- 5. COUNTRY & STORE ANALYSIS
-- ============================================================

-- 5.1 Sales by Country
SELECT
    st.country,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY total_sales DESC;


-- 5.2 Orders by Country
SELECT
    st.country,
    COUNT(DISTINCT s.ordernumber) AS total_orders
FROM sales s
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY total_orders DESC;


-- 5.3 Average Order Value by Country
SELECT
    st.country,
    SUM(s.quantity * p.unitpriceusd)::numeric
    / COUNT(DISTINCT s.ordernumber) AS average_order_value
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY average_order_value DESC;


-- 5.4 Quantity by Country
SELECT
    st.country,
    SUM(s.quantity) AS total_quantity
FROM sales s
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY total_quantity DESC;


-- 5.5 Average Quantity per Order by Country
SELECT
    st.country,
    SUM(s.quantity)::numeric
    / COUNT(DISTINCT s.ordernumber)
    AS average_quantity_per_order
FROM sales s
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY average_quantity_per_order DESC;


-- 5.6 Sales by State
SELECT
    st.country,
    st.state,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country, st.state
ORDER BY total_sales DESC;



-- ============================================================
-- 6. SALES TREND ANALYSIS
-- ============================================================

-- 6.1 Annual Sales
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY EXTRACT(YEAR FROM s.orderdate)
ORDER BY year;


-- 6.2 Monthly Sales
SELECT
    DATE_TRUNC('month', s.orderdate) AS month,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY DATE_TRUNC('month', s.orderdate)
ORDER BY month;


-- 6.3 Monthly Orders
SELECT
    DATE_TRUNC('month', orderdate) AS month,
    COUNT(DISTINCT ordernumber) AS total_orders
FROM sales
GROUP BY DATE_TRUNC('month', orderdate)
ORDER BY month;


-- 6.4 Monthly Sales and Orders
SELECT
    DATE_TRUNC('month', s.orderdate) AS month,
    COUNT(DISTINCT s.ordernumber) AS total_orders,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY DATE_TRUNC('month', s.orderdate)
ORDER BY month;



-- ============================================================
-- 7. BUSINESS DECLINE ANALYSIS
-- ============================================================

-- 7.1 2019 vs 2020 Annual Sales
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    SUM(s.quantity * p.unitpriceusd) AS total_sales,
    COUNT(DISTINCT s.ordernumber) AS total_orders
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
WHERE EXTRACT(YEAR FROM s.orderdate) IN (2019, 2020)
GROUP BY EXTRACT(YEAR FROM s.orderdate)
ORDER BY year;


-- 7.2 March-April Sales by Year
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    SUM(s.quantity * p.unitpriceusd) AS total_sales,
    COUNT(DISTINCT s.ordernumber) AS total_orders
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
WHERE EXTRACT(YEAR FROM s.orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM s.orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM s.orderdate)
ORDER BY year;


-- 7.3 March-April Sales by Country
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    st.country,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN stores st
    ON s.storekey = st.storekey
WHERE EXTRACT(YEAR FROM s.orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM s.orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM s.orderdate), st.country
ORDER BY st.country, year;


-- 7.4 March-April Sales by Category
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    p.category,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
WHERE EXTRACT(YEAR FROM s.orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM s.orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM s.orderdate), p.category
ORDER BY p.category, year;


-- 7.5 March-April Active Customers
SELECT
    EXTRACT(YEAR FROM orderdate) AS year,
    COUNT(DISTINCT customerkey) AS active_customers
FROM sales
WHERE EXTRACT(YEAR FROM orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM orderdate)
ORDER BY year;


-- 7.6 March-April Orders per Active Customer
SELECT
    EXTRACT(YEAR FROM orderdate) AS year,
    COUNT(DISTINCT ordernumber)::numeric
    / COUNT(DISTINCT customerkey)
    AS orders_per_active_customer
FROM sales
WHERE EXTRACT(YEAR FROM orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM orderdate)
ORDER BY year;


-- 7.7 March-April Average Order Value
SELECT
    EXTRACT(YEAR FROM s.orderdate) AS year,
    SUM(s.quantity * p.unitpriceusd)::numeric
    / COUNT(DISTINCT s.ordernumber)
    AS average_order_value
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
WHERE EXTRACT(YEAR FROM s.orderdate) IN (2019, 2020)
  AND EXTRACT(MONTH FROM s.orderdate) IN (3, 4)
GROUP BY EXTRACT(YEAR FROM s.orderdate)
ORDER BY year;



-- ============================================================
-- 8. TOP PRODUCT CONCENTRATION
-- ============================================================

-- 8.1 Top 5 Products
SELECT
    p.productname,
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.productname
ORDER BY total_sales DESC
LIMIT 5;


-- 8.2 Top 5 Products Revenue Share
WITH product_sales AS (
    SELECT
        p.productname,
        SUM(s.quantity * p.unitpriceusd) AS total_sales
    FROM sales s
    JOIN products p
        ON s.productkey = p.productkey
    GROUP BY p.productname
),
top_five AS (
    SELECT SUM(total_sales) AS top_five_sales
    FROM (
        SELECT total_sales
        FROM product_sales
        ORDER BY total_sales DESC
        LIMIT 5
    ) t
),
overall AS (
    SELECT SUM(total_sales) AS overall_sales
    FROM product_sales
)
SELECT
    top_five.top_five_sales,
    overall.overall_sales,
    top_five.top_five_sales
        / overall.overall_sales * 100
        AS top_five_revenue_share
FROM top_five, overall;



-- ============================================================
-- 9. CATEGORY REVENUE CONCENTRATION
-- ============================================================

SELECT
    p.category,
    SUM(s.quantity * p.unitpriceusd) AS total_sales,
    SUM(s.quantity * p.unitpriceusd)
        / SUM(SUM(s.quantity * p.unitpriceusd))
          OVER () * 100 AS sales_percentage
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
GROUP BY p.category
ORDER BY total_sales DESC;



-- ============================================================
-- 10. COUNTRY REVENUE CONCENTRATION
-- ============================================================

SELECT
    st.country,
    SUM(s.quantity * p.unitpriceusd) AS total_sales,
    SUM(s.quantity * p.unitpriceusd)
        / SUM(SUM(s.quantity * p.unitpriceusd))
          OVER () * 100 AS sales_percentage
FROM sales s
JOIN products p
    ON s.productkey = p.productkey
JOIN stores st
    ON s.storekey = st.storekey
GROUP BY st.country
ORDER BY total_sales DESC;



-- ============================================================
-- END OF ANALYSIS
-- ============================================================