# Sales Data Analysis Using SQL

## Objective:
This project is all about understanding shopping habits and sales trends using SQL. By analyzing real sales data, we uncover insights into customer preferences, peak shopping times, and the profitability of different product categories. These findings help businesses make smarter decisions—whether it's improving inventory management, refining marketing strategies, or identifying loyal customers who bring the most value. Ultimately, it's about turning raw numbers into meaningful actions that drive growth. 🚀

## Steps

### 1) DataBase Creation
```sql
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
```

### 2)Creating Table To Store Data
```sql
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
```

### 3) Data Cleaning
```sql
-- View top 10 rows from the salestable
select * from salestable
limit 10;

-- Find Total Rows from the salestable
select count(*) from salestable;

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
```

### 4) Solving the Business Problems
#### i) Which age group has the highest number of purchases?
```sql
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
```

#### ii) What is the gender distribution of customers making purchases?
```sql
select gender,
       count(gender) as ditribution_of_gebder
from salestable
	   group by gender;
```

#### iii) Who spend on average more money for purcheses male or female?
```sql
select gender, 
       round(avg(total_sale),2) as avg_sales
from salestable
      group by gender
	  order by avg_sales desc;
```

#### iv) Find top 5 most valuable customers
```sql
select gender,
       customer_id,
       sum(total_sale) as sales
from salestable
       group by gender, customer_id
	   order by sales desc
	   limit 5;
```

#### v) What are the total sales per category?
```sql
select category,
       sum(total_sale) as Total_Sales
from salestable
       group by category
	   order by Total_Sales desc;
```

#### vi) Which time of day generates the highest sales volume?
```sql
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
```

#### vii) What is the average price per unit for each category?
```sql
select category,
       round(avg (price_per_unit),2) avg_price_per_unit
from salestable
group by category
order by avg_price_per_unit desc;
```

#### viii) What is the total sales per month?
```sql
select extract(month from sale_date) as month,
       sum(total_sale) as Revenue
from salestable
group by month
order by Revenue desc;
```

### ix) Which category has the heighest avg profit margin?
```sql
select * from salestable;
select round(avg( total_sale - cogs), 2) as avg_profit_margin,
       category
from salestable
group by category
order by avg_profit_margin desc;
```

#### x) Identify the count of unique customers
```sql
select count(distinct(customer_id)) as unique_customers_count
from salestable;
```

#### xi) what is monthly sales growth trend over time?
```sql
SELECT extract(year from sale_date) AS year, 
       extract ( month from sale_date) AS month, 
       SUM(total_sale) AS revenue 
FROM salestable 
GROUP BY year, month 
ORDER BY year, month;
```

### 5) Key Findings and Conclusion
#### i) The analysis reveals that the older age group (above 40 years) has the highest number of purchases, indicating a strong purchasing power or a preference for specific products.

#### ii) The distribution of purchases shows a slight skew towards female consumers, indicating potential gender-based differences in spending behavior.

#### iii) The analysis indicates no significant difference in spending between males and females based on average sales.

#### iv) The analysis highlights that electronics is the highest-selling category, suggesting strong consumer demand in this segment.

#### v) The analysis indicates that evening and night hours generate the highest sales, which could be due to several key factors like Consumer habits, Online shopping trends, Peak retail hours.

#### vi) The analysis reveals that the clothing category has the lowest average price per unit.

#### vii) December records the highest revenue due to holiday shopping, promotions, and year-end bonuses.

#### viii) The analysis shows that beauty products have the highest average profit margin, indicating strong profitability in this segment.

#### ix) The dataset includes 155 unique customers, which provides insights into customer diversity and engagement.














