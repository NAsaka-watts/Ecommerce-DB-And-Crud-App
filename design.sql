-- ecommerce_db.sql
-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ecommerce_db;

-- Products categories (one-to-many: category -> products)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

CREATE TABLE categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NULL,
  sku VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  stock INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Customers
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(200) NOT NULL UNIQUE,
  phone VARCHAR(30),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Orders (one-to-many: customer -> orders)
CREATE TABLE `orders` (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pending','paid','shipped','completed','cancelled') NOT NULL DEFAULT 'pending',
  total DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Order items (many-to-many between orders and products, implemented as associative table)
CREATE TABLE order_items (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES `orders`(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Sample seed data
INSERT INTO categories (name, description) VALUES
('Laptops','Portable computers'),
('Accessories','Computer accessories and peripherals');

INSERT INTO products (category_id, sku, name, description, price, stock) VALUES
(1, 'LAP-HP-15', 'HP 15-inch Laptop', '15-inch laptop, 8GB RAM, 256GB SSD', 549.99, 10),
(1, 'LAP-DEL-14', 'Dell Inspiron 14', '14-inch laptop, 8GB RAM, 512GB SSD', 699.99, 5),
(2, 'MOU-LOG-1', 'Logitech Mouse', 'Wireless optical mouse', 19.99, 100),
(2, 'KEY-MEK-1', 'Mechanical Keyboard', 'Compact mechanical keyboard', 79.50, 50);

INSERT INTO customers (first_name,last_name,email,phone) VALUES
('John','Doe','john.doe@example.com','+254700000001'),
('Jane','Smith','jane.smith@example.com','+254700000002');

-- Create a sample order
INSERT INTO `orders` (customer_id, status, total) VALUES (1, 'pending', 0.00);
-- assume order id 1
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 549.99),
(1, 3, 1, 19.99);

-- update order total
UPDATE `orders` o
JOIN (
  SELECT order_id, SUM(quantity * unit_price) AS order_total FROM order_items GROUP BY order_id
) oi ON o.order_id = oi.order_id
SET o.total = oi.order_total;