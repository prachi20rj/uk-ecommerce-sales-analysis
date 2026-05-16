SELECT
    country,
    COUNT(DISTINCT customer_id)                       AS customers,
    COUNT(DISTINCT invoice_no)                        AS orders,
    ROUND(SUM(quantity * unit_price)::numeric, 2)     AS revenue
FROM retail
WHERE country != 'United Kingdom'
GROUP BY country
ORDER BY revenue DESC
LIMIT 15;