WITH monthly AS (
    SELECT
        DATE_TRUNC('month', invoice_date)             AS month,
        ROUND(SUM(quantity * unit_price)::numeric, 2) AS revenue
    FROM retail
    GROUP BY 1
)
SELECT
    TO_CHAR(month, 'Mon YYYY')                        AS month_name,
    revenue,
    LAG(revenue) OVER (ORDER BY month)                AS prev_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100, 1
    )                                                 AS mom_growth_pct
FROM monthly
ORDER BY month;