
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    price DECIMAL (10,2) CHECK (price > 0)
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    email TEXT UNIQUE NOt NULL
);

INSERT INTO books (title, author, price) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 10.99),
('1984', 'George Orwell', 8.99),
('To Kill a Mockingbird', 'Harper Lee', 12.50);

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com'),
('Bob', 'Smith', 'bob.smith@example.com');


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    book_id INT NOT NULL,
    order_date TIMESTAMP Default NOW(),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, book_id,order_date) VALUES
(1, 1, '2024-11-15'),
(2, 2, '2024-11-16');


/*### 4. **Foreign keys 2**
Create a `reviews` table which stores user reviews on books. A review has a text and a rating.
- Can you figure out which columns are needed?
- Which keys does the table have?
- Assume that a user can only leave one review per book at most. Come up with one or more primary keys for the table. */

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    book_id INT NOT NULL,
    customer_id INT NOT NULL,
    review TEXT,
    rating INT NOT NULL CHECK (rating > 1 AND rating < 5),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    UNIQUE (customer_id, book_id)
);

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM reviews;