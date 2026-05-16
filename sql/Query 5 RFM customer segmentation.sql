WITH rfm AS (
    SELECT
        customer_id,
        MAX(invoice_date)                              AS last_purchase,
        COUNT(DISTINCT invoice_no)                     AS frequency,
        ROUND(SUM(quantity * unit_price)::numeric, 2)  AS monetary
    FROM retail
    WHERE customer_id IS NOT NULL
      AND customer_id != 'nan'
    GROUP BY customer_id
),
scored AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY last_purchase DESC)   AS r_score,
        NTILE(4) OVER (ORDER BY frequency)            AS f_score,
        NTILE(4) OVER (ORDER BY monetary)             AS m_score
    FROM rfm
)
SELECT *,
    CASE
        WHEN r_score = 4 AND f_score >= 3 THEN 'Champion'
        WHEN r_score >= 3 AND f_score >= 2 THEN 'Loyal'
        WHEN r_score >= 2                  THEN 'At risk'
        ELSE 'Lost'
    END AS segment
FROM scored
ORDER BY monetary DESC;