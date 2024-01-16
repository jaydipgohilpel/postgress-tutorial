https://www.youtube.com/watch?v=85pG_pDkITY&ab_channel=DerekBanas
for all query data in this video description

1)

CREATE OR REPLACE FUNCTION fn_get_sum(vall int, val2 int)
RETURNS int AS
$body$
DECLARE
ans int;
BEGIN
	ans = vall + val2;
	RETURN ans;
END
$body$
LANGUAGE plpgsql
SELECT fn_get_sum(4,5);


2)


CREATE OR REPLACE FUNCTION fn_get_random_number (min_val int, max_val int) RETURNS int AS
$body$
DECLARE
	rand int;
BEGIN
	SELECT random()*(max_val - min_val) + min_val INTO rand;
	RETURN rand;
END;
$body$
LANGUAGE plpgsql;
SELECT fn_get_random_number (1,500);

3)

ody$
DECLARE
	rand int;
	emp record;
BEGIN
	SELECT random() * (5-1) + 1 INTO rand;
	SELECT *
	FROM sales_person
	INTO emp
	WHERE id = rand;
	RETURN CONCAT(emp.first_name, ' ', emp.last_name);
END;
$body$
LANGUAGE plpgsql;

select fn_get_random_salesperson();

5)

CREATE OR REPLACE FUNCTION fn_get_sum_2(In v1 int,in v2 int ,out ans int) AS
$body$
BEGIN
	ans:=v1+v2;
END;
$body$
LANGUAGE plpgsql;


select fn_get_sum_2(5,50);


6)

CREATE OR REPLACE FUNCTION fn_get_cust_birthday(IN the_month int, OUT bd_month int, OUT bd_day int, OUT f_name varchar, OUT l_name varchar)
AS
$body$
BEGIN
	SELECT EXTRACT (MONTH FROM birth_date), EXTRACT (DAY FROM birth_date),
	first_name, last_name
	INTO bd_month, bd_day, f_name, l_name
	FROM customer
	WHERE EXTRACT (MONTH FROM birth_date) = the_month
	LIMIT 1;
END;
$body$
LANGUAGE plpgsql;
SELECT fn_get_cust_birthday(12);

7)

CREATE OR REPLACE FUNCTION fn_get_sales_people()
RETURNS SETOF sales_person AS

$body$
BEGIN
	return query
	select *
	from sales_person;
END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_sales_people()).*;

8)

CREATE OR REPLACE FUNCTION fn_get_10_expensive_product()
RETURNS TABLE(
	name varchar,
	supplier varchar,
	price numeric
) AS
$body$
BEGIN
	return query
	select product.name, product.supplier, item.price
	from item
	natural join product
	order by item.price desc
	limit 10;
END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_10_expensive_product()).*;

9)

CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month int)
RETURNS varchar AS
$body$
DECLARE
	total_orders int;
BEGIN
	select count(purchase_order_number)
	into total_orders
	from sales_order
	where EXTRACT(MONTH FROM time_order_taken) = the_month;
	IF total_orders > 5 THEN
		return concat(total_orders,' Orders : Doing Good');
	ELSEIF total_orders < 5 THEN
		return concat(total_orders,' Orders : Doing Bad');
	ELSE return concat(total_orders,' Orders : On Target');
	END IF;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_check_month_orders(9);

10)

CREATE OR REPLACE FUNCTION fn_check_month_orders2(the_month int)
RETURNS varchar AS
$body$
DECLARE
	total_orders int;
BEGIN
	select count(purchase_order_number)
	into total_orders
	from sales_order
	where EXTRACT(MONTH FROM time_order_taken) = the_month;
	CASE
		WHEN total_orders < 1 THEN
			return concat(total_orders,' Orders : Doing Bad');
		WHEN total_orders > 1 AND total_orders < 5 THEN
			return concat(total_orders,' Orders : On Target');
		ELSE 
			return concat(total_orders,' Orders : Doing Good');
	END CASE;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_check_month_orders2(12);

11)

CREATE OR REPLACE FUNCTION fn_loop_tes(max_num int)
RETURNS int AS
$body$
DECLARE
	j int default 1;
	total int default 0;
BEGIN
	loop
		total:=total+j;
		j:=j+1;
		exit when j > max_num;
	end loop;
	return total;
	
END;
$body$
LANGUAGE plpgsql;

SELECT fn_loop_tes(3);

12)

CREATE OR REPLACE FUNCTION fn_for_loop(max_num int)
RETURNS int AS
$body$
DECLARE
	total int default 0;
BEGIN

	for i in 1 .. max_num by 1
	loop
		total:=total+i;
	end loop;
	return total;
	
END;
$body$
LANGUAGE plpgsql;

SELECT fn_for_loop(5);

13)

CREATE OR REPLACE FUNCTION fn_for_loop_revers(max_num int)
RETURNS int AS
$body$
DECLARE
	total int default 0;
BEGIN

	for i in reverse max_num  ..  1 by 1
	loop
		total:=total+i;
	end loop;
	return total;
	
END;
$body$
LANGUAGE plpgsql;

SELECT fn_for_loop_revers(5);





