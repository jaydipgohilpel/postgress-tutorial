CREATE TABLE customer (
first_name VARCHAR (30) NOT NULL,
last_name VARCHAR (30) NOT NULL, 
email VARCHAR(60) NOT NULL,
company VARCHAR(60) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR (2) NOT NULL,
zip SMALLINT NOT NULL,
phone VARCHAR (20) NOT NULL,
birth_date DATE NULL,
sex CHAR(1) NOT NULL,
date_entered TIMESTAMP NOT NULL,
id SERIAL PRIMARY KEY);

INSERT INTO customer(first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered)
VALUES ('Christopher', 'Jones', 'christopherjones@bp.com', 'BP', '347 Cedar St', 'Lawrenceville', 'GA',
'30044', '348-848-8291',
'1938-09-11', 'M', current_timestamp);

CREATE TYPE sex_type as enum
('M','F');

ALTER TABLE customer
ALTER COLUMN sex TYPE sex_type USING sex::sex_type;


CREATE TABLE sales_person ( 
first_name VARCHAR (30) NOT NULL, 
last_name VARCHAR(30) NOT NULL,
email VARCHAR(60) NOT NULL, 
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR (2) NOT NULL DEFAULT 'PA', 
zip SMALLINT NOT NULL,
phone VARCHAR (20) NOT NULL,
birth_date DATE NULL,
sex sex_type NOT NULL,
date_hired TIMESTAMP NOT NULL,
id SERIAL PRIMARY KEY
);


CREATE TABLE product_type( 
	name VARCHAR(30) NOT NULL,
	id SERIAL PRIMARY KEY
);
