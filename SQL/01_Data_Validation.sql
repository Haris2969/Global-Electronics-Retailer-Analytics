-- ============================================
-- Global Electronics Retailer Analytics
-- Data Validation Queries
-- ============================================

-- 1. Customers row count
SELECT COUNT(*) AS customers_count
FROM customers;


-- 2. Products row count
SELECT COUNT(*) AS products_count
FROM products;


-- 3. Sales row count
SELECT COUNT(*) AS sales_count
FROM sales;


-- 4. Stores row count
SELECT COUNT(*) AS stores_count
FROM stores;


-- 5. Exchange Rates row count
SELECT COUNT(*) AS exchange_rates_count
FROM exchange_rates;


-- 6. Data Dictionary row count
SELECT COUNT(*) AS data_dictionary_count
FROM data_dictionary;


-- 7. Check Sales -> Customers unmatched records
SELECT COUNT(*) AS unmatched_customers
FROM sales s
LEFT JOIN customers c
    ON s.customerkey = c."CustomerKey"
WHERE c."CustomerKey" IS NULL;


-- 8. Check Sales -> Products unmatched records
SELECT COUNT(*) AS unmatched_products
FROM sales s
LEFT JOIN products p
    ON s.productkey = p.productkey
WHERE p.productkey IS NULL;


-- 9. Check Sales -> Stores unmatched records
SELECT COUNT(*) AS unmatched_stores
FROM sales s
LEFT JOIN stores st
    ON s.storekey = st.storekey
WHERE st.storekey IS NULL;


-- 10. Check Sales -> Exchange Rates unmatched records
SELECT COUNT(*) AS unmatched_exchange_rates
FROM sales s
LEFT JOIN exchange_rates er
    ON s.orderdate::date = er.date
   AND s.currencycode = er.currencycode
WHERE er.date IS NULL;
