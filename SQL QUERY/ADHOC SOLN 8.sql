#TASK 8
WITH temp_table AS (
  SELECT date,month(date_add(date,interval 4 month)) AS period, fiscal_year,sold_quantity 
FROM fact_sales_monthly
)
SELECT CASE 
   when period/3 <= 1 then "Q1"
   when period/3 <= 2 and period/3 > 1 then "Q2"
   when period/3 <=3 and period/3 > 2 then "Q3"
   when period/3 <=4 and period/3 > 3 then "Q4" END quarter,
 round(sum(sold_quantity)/1000000,2) as total_sold_quanity_in_millions FROM temp_table
WHERE fiscal_year = 2020
GROUP BY quarter
ORDER BY total_sold_quanity_in_millions DESC ;