
select * from dbo.pizza_sales;



--     A. KPI’s


--1. Total Revenue:

select sum(total_price) Total_Revenue
from pizza_sales;


--2. Average Order Value

select sum(total_price)/count(distinct order_id) Avg_Order_Value
from pizza_sales;


--3. Total Pizzas Sold

select sum(quantity) Total_Pizza_Sold
from pizza_sales;


--4. Total Orders

select count(distinct order_id) Total_Orders
from pizza_sales;


--5. Average Pizzas Per Order

select cast(
			cast(sum(quantity)as decimal(10,2))/
			cast(count(distinct order_id)as decimal(10,2))
			as decimal(10,2)) Avg_Pizza_Per_Order
from pizza_sales;




--    B. Daily Trend for Total Orders

select
	   DATENAME(DW, order_date) AS Order_Day,
	   COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales
GROUP BY DATENAME(DW, order_date);




-- C. Monthly Trend for Orders

select
	   DATENAME(MONTH, order_date) AS Month_Name,
	   COUNT(DISTINCT order_id) AS Total_Orders
from pizza_sales
GROUP BY DATENAME(MONTH, order_date)
Order by Total_Orders DESC;




-- D. % of Sales by Pizza Category

SELECT
	  pizza_category,
	  CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Revenue,
	  CAST(SUM(total_price) * 100 / (SELECT SUM(total_price)
		   from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category




-- E. % of Sales by Pizza Size in Q1

Select
	  pizza_size,
	  CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Price,
	  CAST(SUM(total_price) * 100 /
		  (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(QUARTER, order_date) = 1)
	       AS DECIMAL(10,2)) AS PCT
from pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
Order by PCT DESC;




-- F. Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
--WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC



-- G. Top 5 Pizzas by Revenue

SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
From pizza_sales
GROUP BY pizza_name
Order by Total_Revenue DESC;




-- H. Bottom 5 Pizzas by Revenue

SELECT Top 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
From pizza_sales
GROUP BY pizza_name
Order by Total_Revenue ASC;




-- I. Top 5 Pizzas by Quantity

SELECT Top 5 pizza_name, SUM(quantity) AS Total_Quantity From pizza_sales
GROUP BY pizza_name
Order by Total_Quantity DESC;




-- J. Bottom 5 Pizzas by Quantity

SELECT Top 5 pizza_name, SUM(quantity) AS Total_Quantity From pizza_sales
GROUP BY pizza_name
Order by Total_Quantity ASC;





-- K. Top 5 Pizzas by Total Orders

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders From pizza_sales
GROUP BY pizza_name
Order by Total_Orders DESC;




-- L. Borrom 5 Pizzas by Total Orders

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
From pizza_sales
GROUP BY pizza_name
Order by Total_Orders ASC;
