# **Q3: Explain the Primary Key and Foreign Key concepts in PostgreSQL?**
## **Primary Key:**
A Primary Key is a field or a set of fields in a table that ensures each record can be uniquely distinguished from all others.

*Characteristics: Uniqueness, can't be NULL*

### <ins>Example:</ins>
<pre>CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name TEXT NOT NULL
);</pre> 

## **Foreign Key:**
A Foreign Key is one or more columns in a table that link to the Primary Key in another table, establishing a connection between the two tables.

*Characteristics: Used to define one-to-many or many-to-one relationships, can be NULL*

### <ins>Example:</ins>
<pre>CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id)
);</pre>




