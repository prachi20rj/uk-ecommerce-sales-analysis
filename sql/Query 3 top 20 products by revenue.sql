SELECT
    description,
    SUM(quantity)                                          AS units_sold,
    ROUND(SUM(quantity * unit_price)::numeric, 2)          AS revenue,
    RANK() OVER (ORDER BY SUM(quantity * unit_price) DESC) AS revenue_rank
FROM retail
GROUP BY description
ORDER BY revenue DESC
LIMIT 20;