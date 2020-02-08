DROP DATABASE IF EXISTS shoe_store;
CREATE DATABASE IF NOT EXISTS shoe_store;
USE shoe_store;

CREATE TABLE IF NOT EXISTS invoices (
invoice_id INT AUTO_INCREMENT,
payment_type VARCHAR(10) NOT NULL,
supplier_id INT NOT NULL,
PRIMARY KEY (invoice_id)
);

CREATE TABLE IF NOT EXISTS customer (
customer_id INT AUTO_INCREMENT,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(10) NOT NULL,
invoice_id INT NOT NULL,
PRIMARY KEY (customer_id),
CONSTRAINT customer_fk FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS shoe (
shoe_id INT AUTO_INCREMENT,
quantity INT NOT NULL,
model VARCHAR(20) NOT NULL,
invoice_id INT NOT NULL,
PRIMARY KEY (shoe_id),
CONSTRAINT shoe_fk FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS branch (
branch_id INT AUTO_INCREMENT,
address VARCHAR(20) NOT NULL,
PRIMARY KEY (branch_id)
);

CREATE TABLE IF NOT EXISTS employee (
employee_id INT AUTO_INCREMENT,
salary INT NOT NULL,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(10) NOT NULL,
start_date DATE NOT NULL,
branch_id INT NOT NULL,
job_title VARCHAR(50) NOT NULL,
PRIMARY KEY (employee_id),
CONSTRAINT employee_fk FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO invoices (invoice_id, payment_type, supplier_id) VALUES 
(1, 'credit', 1),
(2, 'credit', 1),
(3, 'credit', 3),
(4, 'cash', 2),
(5, 'credit', 5),
(6, 'cash', 8),
(7, 'cash', 2),
(8, 'credit', 2),
(9, 'credit', 4),
(10, 'cash', 6);

INSERT INTO customer (customer_id, first_name, last_name, invoice_id) VALUES 
(1, 'Kevin', 'Zheng', 1),
(2, 'Jocelyn', 'Chan', 2),
(3, 'Leroy', 'Jenkins', 4),
(4, 'Joe', 'Schmoe', 3),
(5, 'Alan', 'Mislove', 7),
(6, 'Bob', 'Smith', 6),
(7, 'Rick', 'Sanchez', 5),
(8, 'Matty', 'Matt', 8),
(9, 'Shea', 'ORourke', 9),
(10, 'Bob', 'Smith', 10);

INSERT INTO shoe (shoe_id, quantity, model, invoice_id) VALUES 
(1, 100, 'flats1', 1),
(2, 50, 'high heels 1', 2),
(3, 75, 'flats2', 4),
(4, 0, 'running shoes1', 3),
(5, 200, 'running shoes v2', 7),
(6, 14, 'adidas ultraboost1', 6),
(7, 29, 'sandals1', 4),
(8, 56, 'boots1', 8),
(9, 9, 'adidas stan smith', 9),
(10, 26, 'canvas shoes1', 6),
(11, 25, 'canvas shoes1', 7);

INSERT INTO branch (branch_id, address) VALUES 
(1, '1 Huntington Ave'),
(2, '10 Newbury St'),
(3, '100 Boylston St');

INSERT INTO employee (employee_id, salary, first_name, last_name, start_date, branch_id, job_title) VALUES 
(1, 40000, 'John', 'White', '2018-12-07', 1, 'sales associate'),
(2, 40000, 'John', 'Black', '2018-12-08', 2, 'sales associate'),
(3, 60000, 'Telvin', 'Smith', '2017-1-15', 3, 'senior sales associate'),
(4, 50000, 'Kemba', 'Walker', '2017-2-23', 1, 'senior sales associate'),
(5, 70000, 'Kevin', 'Durant', '2015-3-18', 2, 'branch manager assistant'),
(6, 80000, 'Kyrie', 'Irving', '2016-3-04', 2, 'branch manager'),
(7, 100000, 'Gordon', 'Hayward', '2015-12-07', 1, 'branch executive'),
(8, 75000, 'Jaylen', 'Brown', '2017-12-08', 2, 'branch manager'),
(9, 40000, 'Jayson', 'Tatum', '2019-5-05', 1, 'sales associate'),
(10, 40000, 'Marcus', 'Smart', '2019-9-09', 3, 'sales associate'),
(11, 150000, 'Kevin', 'Zheng', '2014-10-11', 1, 'VP of Marketing'),
(12, 200000, 'Big', 'Boss', '2012-12-13', 1, 'CEO'),
(13, 175000, 'Jocelyn', 'Chan', '2013-12-03', 1, 'VP of Sales'),
(14, 40000, 'Tom', 'Brady', '2019-11-30', 3, 'sales associate');


-- procedure track_shoes_sold takes in a shoe model, outputs invoices that contain that shoe model
DROP PROCEDURE IF EXISTS track_shoes_sold;

-- Change statement delimiter from semicolon to double front slash

DELIMITER //
CREATE PROCEDURE track_shoes_sold(
	IN model_name VARCHAR(20)
)
BEGIN 
	SELECT invoices.invoice_id
    FROM shoe INNER JOIN invoices ON shoe.invoice_id = invoices.invoice_id
    WHERE model = model_name;
    END//
DELIMITER ;

CALL track_shoes_sold('flats1');
CALL track_shoes_sold('canvas shoes1');
CALL track_shoes_sold('adidas stan smith');
CALL track_shoes_sold('sandals1');
CALL track_shoes_sold('adidas ultraboost1');




 








