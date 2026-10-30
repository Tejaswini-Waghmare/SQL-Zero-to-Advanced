-- PostgreSQL 14+. Run this file from the repository root in psql using: \i setup.sql
DROP TABLE IF EXISTS events, order_items, orders, products, customers, messy_contacts CASCADE;
CREATE TABLE customers (customer_id INTEGER PRIMARY KEY, customer_name TEXT NOT NULL, city TEXT, signup_date DATE, segment TEXT);
CREATE TABLE products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category TEXT, list_price NUMERIC(10,2));
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER REFERENCES customers(customer_id), order_date DATE, status TEXT, channel TEXT, region TEXT);
CREATE TABLE order_items (item_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id), product_id INTEGER REFERENCES products(product_id), quantity INTEGER, unit_price NUMERIC(10,2));
CREATE TABLE events (event_id INTEGER PRIMARY KEY, customer_id INTEGER REFERENCES customers(customer_id), event_date DATE, event_type TEXT);
CREATE TABLE messy_contacts (contact_id INTEGER PRIMARY KEY, raw_email TEXT, raw_city TEXT);
\copy customers FROM 'datasets/customers.csv' WITH (FORMAT csv, HEADER true)
\copy products FROM 'datasets/products.csv' WITH (FORMAT csv, HEADER true)
\copy orders FROM 'datasets/orders.csv' WITH (FORMAT csv, HEADER true)
\copy order_items FROM 'datasets/order_items.csv' WITH (FORMAT csv, HEADER true)
\copy events FROM 'datasets/events.csv' WITH (FORMAT csv, HEADER true)
\copy messy_contacts FROM 'datasets/messy_contacts.csv' WITH (FORMAT csv, HEADER true)
SELECT 'customers' AS table_name, COUNT(*) FROM customers UNION ALL SELECT 'orders',COUNT(*) FROM orders UNION ALL SELECT 'order_items',COUNT(*) FROM order_items;
