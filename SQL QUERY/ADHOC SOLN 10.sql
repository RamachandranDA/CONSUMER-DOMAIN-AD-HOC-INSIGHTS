#TASK 10
WITH temp_table AS (
    SELECT
        division,
        s.product_code,
        p.product,
        p.variant,
        SUM(sold_quantity) AS total_sold_quantity,
        RANK() OVER (PARTITION BY division ORDER BY SUM(sold_quantity) DESC) AS rank_order
    FROM
        fact_sales_monthly s
        JOIN dim_product p ON s.product_code = p.product_code
    WHERE
        fiscal_year = 2021
    GROUP BY
        division, s.product_code, p.product, p.variant
)
SELECT
    division,
    product_code,
    CONCAT(product, '(', variant, ')') AS product,
    total_sold_quantity,
    rank_order
FROM
    temp_table
WHERE
    rank_order IN (1, 2, 3);
