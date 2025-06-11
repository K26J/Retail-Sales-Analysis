-- Database: retail_sales

-- DROP DATABASE IF EXISTS retail_sales;

CREATE DATABASE retail_sales
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create Table SalesTable
create table SalesTable (
                         transactions_id INT Primary Key,	
						 sale_date DATE,
						 sale_time TIME,	
						 customer_id INT,	
						 gender VARCHAR(15),
						 age INT,
						 category VARCHAR(25),	
						 quantiy INT,	
						 price_per_unit DECIMAL (10,2),
						 cogs DECIMAL (10,2),	
						 total_sale INT

                         );

-- View top 10 rows from the salestable
select * from salestable
limit 10;

-- Find Total Rows from the salestable
select count(*) from salestable;
-- There are 2000 rows in the salestable

-- Identify the null values in the salestable
select * 
       from salestable
       where transactions_id is null
	   or 
	   sale_date is null
	   or
	   sale_time is null
	   or
	   customer_id is null
	   or
	   gender is null
	   or 
	   age is null
	   or 
	   category is null
	   or 
	   quantiy is null
	   or 
	   price_per_unit is null
	   or
	   cogs is null
	   or 
	   total_sale is null;


-- Removing the Null values from the data
delete from salestable
       where transactions_id is null
	   or 
	   sale_date is null
	   or
	   sale_time is null
	   or
	   customer_id is null
	   or
	   gender is null
	   or 
	   age is null
	   or 
	   category is null
	   or 
	   quantiy is null
	   or 
	   price_per_unit is null
	   or
	   cogs is null
	   or 
	   total_sale is null;

-- Rechecking total number of rows in the salestable
select count(*) from salestable;
--There are 1987 cleaned rows present in the salestable


-- 1) Which age group has the highest number of purchases?
select
      case 
      when age < 21 then 'teenagers'
	  when age between 21 and 40 then 'matuare'
	  when age > 40 then 'old'
	  end as age_group,
      sum(quantiy) as number_of_purcheses
	  from salestable
	  group by age_group
	  order by number_of_purcheses desc
	  limit 1;
-- The Old age group has the highest number of purcheses that is age greater than 40.

-- 2) What is the gender distribution of customers making purchases?
select gender,
       count(gender) as ditribution_of_gebder
from salestable
	   group by gender;
-- It is clearly seen that distribution of purcheses is slightly skewed towards the Females.

-- 3) Who spend on average more money for purcheses male or female?
select gender, 
       round(avg(total_sale),2) as avg_sales
from salestable
      group by gender
	  order by avg_sales desc;
-- There is no significant difference between expances of male and female based on the avg_sales.

--4) Find top 5 most valuable customers
select gender,
       customer_id,
       sum(total_sale) as sales
from salestable
       group by gender, customer_id
	   order by sales desc
	   limit 5;
-- These are the most valuable customers.

--5) What are the total sales per category?
select category,
       sum(total_sale) as Total_Sales
from salestable
       group by category
	   order by Total_Sales desc;
-- It is observed that the heighest sales category is electronics.

-- 6) Which time of day generates the highest sales volume?
SELECT  
    CASE  
        WHEN extract (hour from sale_time) BETWEEN 0 AND 6 THEN 'early_morning'  
        WHEN extract (hour from sale_time) BETWEEN 7 AND 12 THEN 'morning'  
        WHEN extract (hour from sale_time) BETWEEN 13 AND 18 THEN 'afternoon'  
        ELSE 'evening_and_night'  
    END AS shifts,  
    SUM(total_sale) AS total_sales  
FROM salestable  
GROUP BY shifts  
ORDER BY total_sales DESC;
-- It is observed that the heighest sales are at evening and night time.

-- 7) What is the average price per unit for each category?
select category,
       round(avg (price_per_unit),2) avg_price_per_unit
from salestable
group by category
order by avg_price_per_unit desc;
-- It is observed that clothing category has the lowest avg_price_per_unit.

-- 8) What is the total sales per month
select extract(month from sale_date) as month,
       sum(total_sale) as Revenue
from salestable
group by month
order by Revenue desc;
-- It is observed that the heighest revenue is in the last month of the year.

-- 9) Which category has the heighest avg profit margin?
select * from salestable;
select round(avg( total_sale - cogs), 2) as avg_profit_margin,
       category
from salestable
group by category
order by avg_profit_margin desc;
-- It is observed that the Beauty products have the heighest avg profit margin.

-- 10) Identify the count of unique customers
select count(distinct(customer_id)) as unique_customers_count
from salestable;
-- There are 155 unique customers.

-- 11) what is monthly sales growth trend over time?
SELECT extract(year from sale_date) AS year, 
       extract ( month from sale_date) AS month, 
       SUM(total_sale) AS revenue 
FROM salestable 
GROUP BY year, month 
ORDER BY year, month;