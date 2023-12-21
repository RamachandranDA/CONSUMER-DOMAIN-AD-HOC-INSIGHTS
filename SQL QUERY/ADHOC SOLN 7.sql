#TASK 7
WITH temp_table AS (
    SELECT
        customer,
        MONTHNAME(date) AS months,
        MONTH(date) AS month_number,
        YEAR(date) AS year,
        (sold_quantity * gross_price) AS gross_sales
    FROM
        fact_sales_monthly s
        JOIN fact_gross_price g ON s.product_code = g.product_code
        JOIN dim_customer c ON s.customer_code = c.customer_code
    WHERE
        customer = 'Atliq exclusive'
)
SELECT
    months,
    year,
    CONCAT(ROUND(SUM(gross_sales) / 1000000, 2), 'M') AS gross_sales
FROM
    temp_table
GROUP BY
    year,months,month_number 
ORDER BY
    year, month_number;
