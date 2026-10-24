-- Small Shop Sales Analysis

CREATE TABLE sales (
    product TEXT,
    quantity INTEGER,
    price INTEGER
);
INSERT INTO sales (product, quantity, price) VALUES
('Rice', 5, 3000),
('Sugar', 3, 2500),
('Cooking Oil', 2, 6000),
('Rice', 4, 3000),
('Sugar', 6, 2500);


---Query 1:View all sales records
SELECT * FROM Sales;

--Query 2:quantity sold per product
SELECT 
  Product, 
  SUM(Quantity) AS Total_quantity
FROM Sales 
GROUP  BY Product
ORDER BY Total_quantity DESC;

---Query 3:Revenue per product
SELECT
  Product, 
  SUM(price*quantity) AS Total_revenue 
FROM Sales
GROUP BY Product
ORDER BY Total_revenue DESC;

---Query 4:Products earning more than TZS 20,000
SELECT Product,
SUM (Quantity*Price) AS Total_revenue 
FROM Sales
GROUP BY Product 
HAVING SUM(quantity*price)>20000
ORDER BY Total_revenue DESC;

-----Query 5: Average sellimg price per product
SELECT Product,
AVG(Price) AS Average_price 
FROM Sales
GROUP BY Product
ORDER BY Average_price DESC;

----Query 6:Highest unit price per product
SELECT Product, MAX(Price) AS Highest_price
FROM Sales 
GROUP BY Product
ORDER BY Highest_price DESC;


----Query 7:Number of transaction per product
SELECT Product ,
COUNT(*) AS number_of_transactions
FROM Sales
GROUP BY Product
ORDER BY number_of_transactions DESC;






