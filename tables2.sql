-- Create a table for products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,                -- 'SERIAL' automatically generates unique IDs
    name TEXT NOT NULL,           -- 'NOT NULL' ensures the product name cannot be empty
    price NUMERIC CHECK (price > 0), -- 'CHECK' ensures the price is greater than 0
    created_at TIMESTAMP DEFAULT NOW()    -- Default timestamp for when the product was added
);

-- Insert some sample data into the products table
INSERT INTO products (name, price) VALUES 
('Laptop', 999.99),
('Phone', 599.99);

-- Attempting to insert a product with a price of 0 or negative will fail due to CHECK constraint
INSERT INTO products (name, price) VALUES ('Invalid Product', -10); -- This will raise an error

-- Attempting to insert a duplicate SKU will fail due to UNIQUE constraint
INSERT INTO products (name, price) VALUES ('Tablet', 299.99); -- This will raise an error

-- Create a view to simplify access to the product data
CREATE VIEW simple_product_overview AS 
SELECT name, price 
FROM products;

-- Query the view
SELECT * FROM product_overview;


-- Query the products table to see the updated data
SELECT * FROM products;

CREATE TABLE users (
    email TEXT PRIMARY KEY,
    username TEXT UNIQUE,  -- Unique constraint. We cant have both as a primary key as then we could have one username with several emails.
    
);

/* 
1. NOT NULL
2. SERIAL
3. DEFAULT
4. UNIQUE
5. CHECK
6. VIEW
*/