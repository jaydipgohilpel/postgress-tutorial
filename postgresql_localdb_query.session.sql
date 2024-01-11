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
    id SERIAL PRIMARY KEY
);
INSERT INTO customer(
        first_name,
        last_name,
        email,
        company,
        street,
        city,
        state,
        zip,
        phone,
        birth_date,
        sex,
        date_entered
    )
VALUES (
        'Christopher',
        'Jones',
        'christopherjones@bp.com',
        'BP',
        '347 Cedar St',
        'Lawrenceville',
        'GA',
        '30044',
        '348-848-8291',
        '1938-09-11',
        'M',
        current_timestamp
    );
CREATE TYPE sex_type as enum ('M', 'F');
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
CREATE TABLE product(
    type_id INTEGER REFERENCES product_type(id),
    name VARCHAR(30) NOT NULL,
    supplier VARCHAR (30) NOT NULL,
    description TEXT NOT NULL,
    id SERIAL PRIMARY KEY
);
CREATE TABLE item(
    product_id INTEGER REFERENCES product(id),
    size INTEGER NOT NULL,
    color VARCHAR(30) NOT NULL,
    picture VARCHAR(256) NOT NULL,
    price NUMERIC (6, 2) NOT NULL,
    id SERIAL PRIMARY KEY
);
CREATE TABLE sales_order(
    cust_id INTEGER REFERENCES customer(id),
    sales_person_id INTEGER REFERENCES sales_person(id),
    time_order_taken TIMESTAMP NOT NULL,
    purchase_order_number INTEGER NOT NULL,
    credit_card_number VARCHAR(16) NOT NULL,
    credit_card_exper_month SMALLINT NOT NULL,
    credit_card_exper_day SMALLINT NOT NULL,
    credit_card_secret_code SMALLINT NOT NULL,
    name_on_card VARCHAR(100) NOT NULL,
    id SERIAL PRIMARY KEY
);
CREATE TABLE sales_item(
    item_id INTEGER REFERENCES item(id),
    sales_order_id INTEGER REFERENCES sales_order(id),
    quantity INTEGER NOT NULL,
    discount NUMERIC (3, 2) NULL DEFAULT 0,
    taxable BOOLEAN NOT NULL DEFAULT FALSE,
    sales_tax_rate NUMERIC (5, 2) NOT NULL DEFAULT 0,
    id SERIAL PRIMARY KEY
);

ALTER TABLE sales_item
ADD day_of_week VARCHAR(8);

ALTER TABLE sales_item
ALTER COLUMN day_of_week
SET NOT NULL;

ALTER TABLE sales_item
    RENAME COLUMN day_of_week TO weekday;
    
INSERT INTO product_type (name)
VALUES ('Business');
INSERT INTO product_type(name)
VALUES ('Casual');
INSERT INTO product_type(name)
VALUES ('Athletic');

INSERT INTO public.product(
	type_id, name, supplier, description)
	VALUES 
(1, 'Grandview', 'Allen Edmonds', 'Classic broguing adds texture to a charming longwing derby crafte'),
(1, 'Clarkston', 'Allen Edmonds', 'Sharp broguing touches up a charming, American-made derby fashion'),

INSERT INTO customer (first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered) VALUES 
('Matthew', 'Martinez', 'matthewmartinez@ge.com', 'GE', '602 Main Place', 'Fontana', 'CA', '92336', '117-997-7764', '1931-09-04', 'M', '2015-01-01 22:39:28'), 
('Melissa', 'Moore', 'melissamoore@aramark.com', 'Aramark', '463 Park Rd', 'Lakewood', 'NJ', '08701', '269-720-7259', '1967-08-27', 'M', '2017-10-20 21:59:29'), 

INSERT INTO sales_person (first_name, last_name, email, street, city, state, zip, phone, birth_date, sex, date_hired) VALUES 
('Jennifer', 'Smith', 'jennifersmith@volkswagen.com', '610 Maple Place', 'Hawthorne', 'CA', '90250', '215-901-2287', '1941-08-09', 'F', '2014-02-06 12:22:48'), 
('Michael', 'Robinson', 'michaelrobinson@walmart.com', '164 Maple St', 'Pacoima', 'CA', '91331', '521-377-4462', '1956-04-23', 'M', '2014-09-12 17:27:23'), 

INSERT INTO item VALUES 
(11, 12, 'Red', 'Coming Soon', 155.65), 
(2, 11, 'Red', 'Coming Soon', 128.87), 
(11, 11, 'Green', 'Coming Soon', 117.52), 
(5, 8, 'Black', 'Coming Soon', 165.39), 

INSERT INTO sales_order VALUES 
(1, 2, '2018-03-23 10:26:23', 20183231026, 5440314057399014, 3, 5, 415, 'Ashley Martin'), 
(8, 2, '2017-01-09 18:58:15', 2017191858, 6298551651340835, 10, 27, 962, 'Michael Smith')

INSERT INTO sales_item
VALUES (24, 70, 2, 0.11, false, 0.0),
    (8, 37, 2, 0.16, false, 0.0)

where time_order_taken > '2018-12-01'
    and time_order_taken < '2018-12-31'
where discount >.15
order by discount asc
limit 20
SELECT concat(first_name, ' ', last_name) as Name,
    phone,
    email,
    sex,
    company
FROM customer
WHERE state ILIKE 'tx';
-- inner join
select item_id,
    item.id,
    price,
    discount
from item
    INNER JOIN sales_item ON item.id = sales_item.id
where discount >.15 -- and price > 120
order by discount desc -- limit 20
select sales_order.id,
    sales_item.quantity,
    item.price,
    (sales_item.quantity * item.price) as total
from sales_order
    join sales_item on sales_item.sales_order_id = sales_order.id
    join item on sales_item.item_id = item.id
order by sales_order.id