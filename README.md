# E-commerce Database and CRUD Application

## Project Overview

This project demonstrates:

1. Designing and implementing a relational database in MySQL for an **E-commerce Store**.
2. Developing a **CRUD Application** using **Node.js (Express)** connected to the database.

The database supports products, customers, orders, and order items. The Node.js app provides RESTful API endpoints for performing CRUD operations.

---

## ⚙️ Tech Stack

* **Database:** MySQL
* **Backend:** Node.js (Express)
* **ORM/Querying:** MySQL2

---

## Database Setup

### Step 1: Create Database

Run the provided SQL script:

```bash
mysql -u root -p < ecommerce_db.sql
```

This will:

* Create the database `ecommerce_db`
* Define tables: `Products`, `Customers`, `Orders`, `OrderItems`
* Add constraints (Primary Keys, Foreign Keys, NOT NULL, UNIQUE)
* Insert sample data

---

## Application Setup

### Step 1: Clone Repo

```bash
git clone <your-repo-url>
cd ecommerce-crud
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Configure Environment Variables

Create a `.env` file based on `.env.example`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=ecommerce_db
PORT=3000
```

### Step 4: Start Server

```bash
npm start
```

Server runs at: [http://localhost:3000](http://localhost:3000)

---

## API Endpoints

### Products

* **GET** `/products` → List all products
* **GET** `/products/:id` → Get product by ID
* **POST** `/products` → Create a new product
* **PUT** `/products/:id` → Update a product
* **DELETE** `/products/:id` → Delete a product

### Customers

* **GET** `/customers` → List all customers
* **GET** `/customers/:id` → Get customer by ID
* **POST** `/customers` → Create a new customer
* **PUT** `/customers/:id` → Update a customer
* **DELETE** `/customers/:id` → Delete a customer

---

## Documentation

You can test endpoints using:

* **Postman** (import endpoints)
* **cURL** commands

Example:

```bash
curl -X GET http://localhost:3000/products
```

---

## Next Steps

* Extend API to manage `Orders` and `OrderItems`
* Add authentication (JWT)
* Deploy using Docker or cloud platform
