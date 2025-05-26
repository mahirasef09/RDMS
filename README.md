# **Q3: Explain the Primary Key and Foreign Key concepts in PostgreSQL.**
## **Primary Key:**
A Primary Key is a field or a set of fields in a table that ensures each record can be uniquely distinguished from all others.

*Characteristics: Uniqueness, can't be NULL.*

### <ins>Example:</ins>
<pre>CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name TEXT NOT NULL
);</pre> 

## **Foreign Key:**
A Foreign Key is one or more columns in a table that link to the Primary Key in another table, establishing a connection between the two tables.

*Characteristics: Used to define one-to-many or many-to-one relationships, can be NULL.*

### <ins>Example:</ins>
<pre>CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id)
);</pre>

# **Q4: What is the difference between the VARCHAR and CHAR data types?**
## **VARCHAR/Variable-length String:**
VARCHAR(n) stores up to n characters without padding, making it flexible and efficient for variable-length data like names or emails.

### <ins>Example:</ins>
<pre>CREATE TABLE user (
    full_name VARCHAR(50),
    email VARCHAR(25)
);</pre> 

## **CHAR/Fixed-length String:**
CHAR(n) stores exactly n characters, padding with spaces if shorter, and is ideal for fixed-length values like country codes.

### <ins>Example:</ins>
<pre>CREATE TABLE employees (
    name VARCHAR(50),
    country_code CHAR(2)
);</pre>

# **Q5: Explain the purpose of the WHERE clause in a SELECT statement.**
## **WHERE clause in a SELECT statement:**
The WHERE clause in a SELECT statement filters the results by applying a condition, so only the rows that satisfy that condition are included in the output.

*Purpose: To retrieve specific rows from a table instead of fetching all data.*
*As a condition: Can use operators like =, >, <, !=, LIKE, IN, BETWEEN etc. and logical operators: AND, OR, NOT.*

### <ins>Example:</ins>
<pre>SELECT * FROM products
WHERE price > 500;</pre> 




