-- Task 1
-- 2NF
CREATE TABLE order1 AS
SELECT orderid, itemid, quantity
FROM public.orders;

CREATE TABLE item AS
SELECT itemid, itemname, price
FROM public.orders;

CREATE TABLE customer AS
SELECT customerid, customername, city
FROM public.orders;

CREATE TABLE order2 AS
SELECT orderid, customerid, date
FROM public.orders;

-- Task 1 queries
-- 1)
SELECT MIN(item.price * order1.quantity)
FROM order1, item
WHERE order1.itemid=item.itemid
-- 2)
SELECT customer.customername, customer.city
FROM customer, order1, order2, item
WHERE order1.itemid=item.itemid 
and order2.customerid=customer.customerid 
and order1.orderid=order2.orderid
GROUP BY customer.customername, customer.city
ORDER BY SUM(item.price * order1.quantity) DESC
LIMIT 1
